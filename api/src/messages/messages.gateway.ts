import { UnauthorizedException } from '@nestjs/common';
import {
  ConnectedSocket,
  MessageBody,
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  SubscribeMessage,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { TokenService } from 'src/shared/token.service';
import {
  IoPrivateMessage,
  IoRoomMessage,
  ServerToClientTypes,
} from 'src/types';
import { RedisService } from 'src/user/redis.service';
import { UserService } from 'src/user/user.service';
import { RoomClientService } from './room.client.service';
import { SocketWithUser } from './types';

@WebSocketGateway()
export class MessagesGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  SocketAuthMiddleWare = async (socket: Socket, next) => {
    try {
      const user = await this.tokenService.validateToken(
        socket.handshake.headers,
      );

      socket['user'] = user; // socket['user'] = socket.user = user
      next();
    } catch (error) {
      next(new UnauthorizedException('Invalid token'));
    }
  };
  constructor(
    private tokenService: TokenService,
    private redis: RedisService,
    private roomService: RoomClientService,
    private userService: UserService,
  ) {}
  clients = [];
  @WebSocketServer()
  server: Server<ServerToClientTypes, ServerToClientTypes>;

  async handleDisconnect(@ConnectedSocket() client: SocketWithUser) {
    await this.redis.removeUser(client.user.id);
  }

  async handleConnection(@ConnectedSocket() client: SocketWithUser) {
    await this.redis.addUser(client.user, client.id);
    const unreadPrivateMessages = await this.redis.getUnreceivedMessages(
      client.user.id,
    );
    this.server
      .to(client.id)
      .emit('unreadPrivateMessages', unreadPrivateMessages);
  }

  afterInit(server: any) {
    RoomClientService.server = server;
    server.use(this.SocketAuthMiddleWare);
  }

  @SubscribeMessage('join')
  handleJoin(
    @MessageBody() room: string,
    @ConnectedSocket() client: SocketWithUser,
  ): string {
    this.roomService.join(room, client);
    return 'joined';
  }

  @SubscribeMessage('leave')
  handleLeave(
    @MessageBody() room: string,
    @ConnectedSocket() client: SocketWithUser,
  ) {
    return this.roomService.leave(room, client);
  }

  @SubscribeMessage('message')
  async handleMessage(
    @MessageBody()
    message: IoRoomMessage | IoPrivateMessage,
    @ConnectedSocket() client: SocketWithUser,
  ): Promise<string> {
    if ('room' in message && message.room) {
      this.roomService.sendMessage(this.server.to(message.room), message);
    } else {
      this.roomService.sendToUser(client, message);
    }
    return 'message sent';
  }

  // Get private messages of user conversation with another user
  @SubscribeMessage('joinPrivateChat')
  async handlePingUser(
    @MessageBody() otherUserId: string,
    @ConnectedSocket() client: SocketWithUser,
  ) {
    const privateMessages = await this.redis.getPrivateMessages(
      otherUserId,
      client.user.id,
    );
    // Add friends together
    this.handleFriendship(client.user.id, otherUserId);

    // Start new chat by sending previous chats
    const peer = await this.redis.getUserInfo(otherUserId);
    client.emit('onPrivateChat', {
      oldMessages: privateMessages.reverse(),
      peer,
    });
  }

  private async handleFriendship(userId: string, friendId: string) {
    // Notify both friends about this new friendship
    const data = await this.userService.addFriend(userId, friendId);
    if (!data) return;

    const [user, friend] = data;
    this.server.to(userId).emit('onNewFriend', {
      user,
    });

    const peerId = await this.redis.getUserClientId(friendId);
    if (!peerId) return;

    this.server.to(peerId).emit('onNewFriend', {
      user: friend,
    });
  }
}
