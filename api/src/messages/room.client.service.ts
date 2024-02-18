import { Injectable } from '@nestjs/common';
import { BroadcastOperator, Server } from 'socket.io';
import {
  IoPrivateMessage,
  IoRoomMessage,
  ServerToClientTypes,
} from 'src/types';
import { RedisService } from 'src/user/redis.service';
import { UserService } from 'src/user/user.service';
import { SocketWithUser } from './types';

@Injectable()
export class RoomClientService {
  static server: Server<any, ServerToClientTypes>;

  constructor(
    private redis: RedisService,
    private userService: UserService,
  ) {}

  sendMessage(br: BroadcastOperator<any, any>, message: IoRoomMessage) {
    const newMessage = { ...message, createdAt: Date.now() };
    if (message.sender !== 'admin') {
      this.redis.addMessage(message.room, newMessage);
    }
    br.emit('newMessage', newMessage);
  }

  async sendToUser(socket: SocketWithUser, message: IoPrivateMessage) {
    const sender = socket.user;
    const newMessage = {
      ...message,
      createdAt: Date.now(),
    };
    await this.redis.addPrivateMessage(sender.id, message.receiver, newMessage);
    const receiverSocketId = await this.redis.getUserClientId(message.receiver);
    // User is offline
    if (!receiverSocketId) {
      await this.redis.addUnreceivedMessagesFromUser(
        message.receiver,
        sender.id,
      );
    }

    RoomClientService.server
      .to([receiverSocketId, socket.id])
      .emit('newMessage', newMessage);
  }

  async join(room: string, client: SocketWithUser) {
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
      room,
    });

    const users = await this.redis.getRoomMembers(room);

    // send an event to notify about the new user in the room (new list)
    RoomClientService.server
      .to(room)
      .emit('roomEvents', { room, users: users });

    // Send old messages to connected client
    const oldRoomMessages = await this.redis.getMessages(room);
    client.emit('oldRoomMessages', {
      room,
      messages: oldRoomMessages.reverse(),
    });

    // Add the room to the user list
    this.userService.addRoomToUser(client.user.id, room);

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
      room,
    });

    const users = await this.redis.getRoomMembers(room);

    RoomClientService.server
      .to(room)
      .emit('roomEvents', { room, users: users });

    // Add the room to the user list
    this.userService.removeRoomFromUser(client.user.id, room);

    return `${client.user.name} Left ${room}`;
  }
}
