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
import { remove } from 'lodash';
import { Server, Socket } from 'socket.io';
import { IoMessage, ServerToClientTypes } from 'src/types';
import { RedisService } from 'src/user/redis.service';
import { TokenService } from 'src/utils';

@WebSocketGateway()
export class MessagesGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  SocketAuthMiddleWare = async (socket: Socket, next) => {
    socket['user'] = {
      id: 'asda',
      name: 'asda',
      email: 'asda',
    }; // socket['user'] = socket.user = user
    next();

    // try {
    //   const user = await this.tokenService.validateToken(
    //     socket.handshake.headers,
    //   );
    //   socket['user'] = user; // socket['user'] = socket.user = user
    //   next();
    // } catch (error) {
    //   next(new UnauthorizedException('Invalid token'));
    // }
  };
  constructor(
    private tokenService: TokenService,
    private redis: RedisService,
  ) {}
  clients = [];
  @WebSocketServer()
  server: Server<any, ServerToClientTypes>;

  async handleDisconnect(client: any) {
    const user = client['user'];

    this.clients = remove(this.clients, (c) => c === client.id);
  }

  async handleConnection(client: Socket, args: any[]) {
    const user = client['user'];
    this.redis.addUser(user.id, client.id);
  }

  afterInit(server: any) {
    server.use(this.SocketAuthMiddleWare);
  }

  @SubscribeMessage('join')
  handleJoin(
    @MessageBody() room: string,
    @ConnectedSocket() client: Socket,
  ): string {
    client.join(room);
    this.redis.addToRoom(room, client['user'].id);
    this.server.to(room).emit('newMessage', {
      message: `${client['user'].name} joined the room`,
      sender: 'admin',
      receiver: room,
    });
    // TODO: update redist to include this to the user
    return `Joined ${room}`;
  }

  @SubscribeMessage('leave')
  handleLeave(
    @MessageBody() room: string,
    @ConnectedSocket() client: Socket,
  ): string {
    client.leave(room);
    this.redis.removeFromRoom(room, client['user'].id);
    this.server.to(room).emit('newMessage', {
      message: `${client['user'].name} left the room`,
      sender: 'admin',
      receiver: room,
    });
    return `Left ${room}`;
  }

  private sendMessageToRoom(room: string, message: IoMessage) {
    this.server.to(room).emit('newMessage', message);
  }
  @SubscribeMessage('message')
  async handleMessage(
    @MessageBody()
    message: IoMessage,
  ): Promise<string> {
    // TODO: maybe we should store this in mongo ?
    if (message.room) {
      this.sendMessageToRoom(message.room, message);
    } else {
      const socketId = await this.redis.getUserClientId(message.receiver);
      this.server.to(socketId).emit('newMessage', message);
    }
    return 'message sent';
  }
}
