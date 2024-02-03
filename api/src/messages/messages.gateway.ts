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
import { ServerToClientTypes } from 'src/types';
import { SocketAuthMiddleWare } from './messages.guard';

@WebSocketGateway()
export class MessagesGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  constructor() {}
  clients = [];
  @WebSocketServer()
  server: Server<any, ServerToClientTypes>;

  handleDisconnect(client: any) {
    console.log('disconnected', client.id);
    this.clients = remove(this.clients, (c) => c === client.id);
  }

  handleConnection(client: Socket, args: any[]) {
    this.clients.push(client.id);
    console.log('connected', this.clients);
  }

  afterInit(server: any) {
    server.use(SocketAuthMiddleWare);
  }

  sendMessage(message: string) {
    this.server.emit('newMessage', { message, sender: '' });
  }

  @SubscribeMessage('event')
  handleEvent(
    @MessageBody() data: string,
    @ConnectedSocket() client: Socket,
  ): string {
    this.server.to(this.clients).emit('newMessage', {
      message: data,
      sender: client.id,
    });
    return data;
  }
}
