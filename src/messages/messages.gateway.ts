import { UseGuards } from '@nestjs/common';
import {
  OnGatewayConnection,
  OnGatewayDisconnect,
  OnGatewayInit,
  WebSocketGateway,
  WebSocketServer,
} from '@nestjs/websockets';
import { Server, Socket } from 'socket.io';
import { ServerToClientTypes } from 'src/types';
import { MessagesGuard, SocketAuthMiddleWare } from './messages.guard';

@WebSocketGateway({
  namespace: 'chatApp',
})
@UseGuards(MessagesGuard)
export class MessagesGateway
  implements OnGatewayInit, OnGatewayConnection, OnGatewayDisconnect
{
  constructor() {}

  @WebSocketServer()
  server: Server<any, ServerToClientTypes>;

  handleDisconnect(client: any) {
    console.log('disconnected', client.id);
  }

  handleConnection(client: Socket, args: any[]) {
    console.log('connected', client['user']);
  }

  afterInit(server: any) {
    server.use(SocketAuthMiddleWare);
  }

  sendMessage(message: string) {
    this.server.emit('newMessage', { message });
  }
}
