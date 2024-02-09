import { Injectable } from '@nestjs/common';
import { BroadcastOperator, Server } from 'socket.io';
import { IoMessage, ServerToClientTypes } from 'src/types';
import { RedisService } from 'src/user/redis.service';
import { SocketWithUser } from '../types';

@Injectable()
export class RoomClientService {
  static server: Server<any, ServerToClientTypes>;

  constructor(private redis: RedisService) {}

  sendMessage(br: BroadcastOperator<any, any>, message: IoMessage) {
    // TODO: save messages
    const newMessage = { ...message, createdAt: Date.now() };
    if (message.sender !== 'admin') {
      this.redis.addMessage(message.room, newMessage);
    }
    br.emit('newMessage', newMessage);
  }

  async join(room: string, client: SocketWithUser) {
    // TODO: send last X messages to new user
    // Add to the user to the room (client)
    client.join(room);
    // add the user to the room list
    this.redis.addUserToRoom(room, client.user.id);
    // add the room to the user list
    this.redis.addRoomToUser(client.user.id, room);
    // send a notification message to the room except the user
    this.sendMessage(client.to(room), {
      message: `${client['user'].name} joined the room`,
      sender: 'admin',
      receiver: room,
      room,
      type: 'join',
    });

    const users = await this.redis.getRoomMembers(room);

    // send an event to notify about the new user in the room (new list)
    RoomClientService.server
      .to(room)
      .emit('roomEvents', { room, users: users, type: 'join' });

    // Send old messages to connected client
    const oldMessages = await this.redis.getMessages(room);
    client.emit('oldMessages', { room, messages: oldMessages.reverse() });

    return `${client.user.name} Joined ${room}`;
  }

  async leave(room: string, client: SocketWithUser) {
    // remove the user from the room (client)
    client.leave(room);
    // remove the user from the room list
    this.redis.removeUserFromRoom(room, client.user.id);
    // remove the room to the user list
    this.redis.removeRoomFromUser(client.user.id, room);
    // send a notification message to the room except the user (leaving)
    this.sendMessage(client.to(room), {
      message: `${client['user'].name} left the room`,
      sender: 'admin',
      receiver: room,
      room,
      type: 'leave',
    });

    const users = await this.redis.getRoomMembers(room);
    client.send('roomEvents', { room, users, type: 'join' });

    RoomClientService.server
      .to(room)
      .emit('roomEvents', { room, users: users, type: 'leave' });

    return `${client.user.name} Left ${room}`;
  }
}
