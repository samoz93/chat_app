import { Injectable } from '@nestjs/common';
import { RedisClientType, createClient } from 'redis';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';
import { IoMessage } from 'src/types';

const USERS_COLLECTION = 'users';
@Injectable()
export class RedisService {
  client: RedisClientType<any>;
  constructor() {}

  async init() {
    this.client = createClient({
      url: `redis://${CONFIG.redisHost}:${CONFIG.redisPort}`,
    });
    const pr = await new Promise((resolve, reject) => {
      this.client
        .on('connect', () => {
          resolve(true);
        })
        .on('error', (error) => {
          reject(error);
        })
        .connect();
    });

    return pr;
  }
  private getRoomKey(room: string) {
    return `room:${room}`;
  }

  private getUserRoomsKey(userId: string) {
    return `user_rooms:${userId}`;
  }

  private getUserInfoKey(userId: string): string {
    return `user_info:${userId}`;
  }

  // Add and remove rooms form/to user
  async addRoomToUser(userId: string, room: string) {
    return await this.client.sAdd(this.getUserRoomsKey(userId), room);
  }

  async removeRoomFromUser(userId: string, room: string) {
    return await this.client.sRem(this.getUserRoomsKey(userId), room);
  }

  async getUserRooms(userId: string) {
    return await this.client.sMembers(this.getUserRoomsKey(userId));
  }

  // Keep track of online/offline users and their client ids
  async addUser(user: UserEntity, clientId: string) {
    await this.client.hSet(this.getUserInfoKey(user.id), {
      id: user.id,
      name: user.name,
      email: user.email,
      rooms: user.rooms?.join(',') ?? '',
    });
    return await this.client.hSet(USERS_COLLECTION, user.id, clientId);
  }

  async removeUser(userId: string) {
    return await this.client.hDel(USERS_COLLECTION, userId);
  }

  async userExists(userId: string) {
    return this.client.hExists(USERS_COLLECTION, userId);
  }

  async getUserClientId(userId: string) {
    return this.client.hGet(USERS_COLLECTION, userId);
  }

  async getUserInfo(userId: string) {
    const data = await this.client.hGetAll(this.getUserInfoKey(userId));
    const user = Object.assign(new UserEntity(), {
      ...data,
      rooms: data.rooms?.split(','),
    });
    return user;
  }

  // Keep track of room's members
  async addUserToRoom(room: string, userId: string) {
    return this.client.sAdd(this.getRoomKey(room), userId);
  }

  removeUserFromRoom(room: string, userId: string) {
    return this.client.sRem(this.getRoomKey(room), userId);
  }

  async getRoomMembers(room: string): Promise<UserEntity[]> {
    const userIDS = await this.client.sMembers(this.getRoomKey(room));
    const users = [];
    for await (const userId of userIDS) {
      users.push(await this.getUserInfo(userId));
    }
    return users;
  }

  // For testing TODO: remove later
  async getAllUsers() {
    const g = await this.client.hGetAll(USERS_COLLECTION);
    return g;
  }

  private getMessagesKey(room: string) {
    const day = `${new Date().getFullYear()}-${new Date().getMonth()}-${new Date().getDate()}`;
    return `messages:${room}:${day}`;
  }
  // Rooms messages
  async addMessage(room: string, message: IoMessage) {
    this.client.lPush(this.getMessagesKey(room), JSON.stringify(message));
  }

  async getMessages(room: string): Promise<IoMessage[]> {
    const data =
      (await this.client.lRange(this.getMessagesKey(room), 0, -1)) || [];
    return data.map((str) => JSON.parse(str)); // (await this.jsonClient.get(`messages:${room}`)) || ([] as IoMessage[])
  }

  onDestroy() {
    this.client.quit();
  }
}
