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
import { IoMessage, ServerToClientTypes } from 'src/types';
import { RedisService } from 'src/user/redis.service';
import { TokenService } from 'src/utils';
import { RoomClientService } from './room.client/room.client.service';
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
      console.log('error', error);

      next(new UnauthorizedException('Invalid token'));
    }
  };
  constructor(
    private tokenService: TokenService,
    private redis: RedisService,
    private roomService: RoomClientService,
  ) {}
  clients = [];
  @WebSocketServer()
  server: Server<ServerToClientTypes, ServerToClientTypes>;

  async handleDisconnect(@ConnectedSocket() client: SocketWithUser) {
    await this.redis.removeUser(client.user.id);
  }

  async handleConnection(@ConnectedSocket() client: SocketWithUser) {
    await this.redis.addUser(client.user, client.id);
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
    console.log('join', room, client.id, client.user.id);

    this.roomService.join(room, client);
    return 'joined';
  }

  @SubscribeMessage('leave')
  handleLeave(
    @MessageBody() room: string,
    @ConnectedSocket() client: SocketWithUser,
  ): string {
    console.log('leave', room, client.id, client.user.id);

    return this.roomService.leave(room, client);
  }

  private sendMessageToRoom(room: string, message: IoMessage) {
    this.server.to(room).emit('newMessage', message);
  }

  @SubscribeMessage('message')
  async handleMessage(
    @MessageBody()
    message: IoMessage,
  ): Promise<string> {
    if (message.room) {
      this.sendMessageToRoom(message.room, message);
    } else {
      const socketId = await this.redis.getUserClientId(message.receiver + '');
      this.server.to(socketId).emit('newMessage', message);
    }
    return 'message sent';
  }
}
