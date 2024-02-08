import { Injectable } from '@nestjs/common';
import { RedisClientType, createClient } from 'redis';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';

const USERS_COLLECTION = 'users';
@Injectable()
export class RedisService {
  redis: RedisClientType<any>;
  constructor() {}

  init() {
    this.redis = createClient({
      url: `redis://${CONFIG.redisHost}:${CONFIG.redisPort}`,
    });
    return new Promise((resolve, reject) => {
      this.redis
        .on('connect', () => {
          resolve(true);
        })
        .on('error', (error) => {
          reject(error);
        })
        .connect();
    });
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
    return await this.redis.sAdd(this.getUserRoomsKey(userId), room);
  }

  async removeRoomFromUser(userId: string, room: string) {
    return await this.redis.sRem(this.getUserRoomsKey(userId), room);
  }

  async getUserRooms(userId: string) {
    return await this.redis.sMembers(this.getUserRoomsKey(userId));
  }

  // Keep track of online/offline users and their client ids
  async addUser(user: UserEntity, clientId: string) {
    await this.redis.hSet(this.getUserInfoKey(user.id), {
      id: user.id,
      name: user.name,
      email: user.email,
      rooms: user.rooms?.join(',') ?? '',
    });
    return await this.redis.hSet(USERS_COLLECTION, user.id, clientId);
  }

  async removeUser(userId: string) {
    return await this.redis.hDel(USERS_COLLECTION, userId);
  }

  async userExists(userId: string) {
    return this.redis.hExists(USERS_COLLECTION, userId);
  }

  async getUserClientId(userId: string) {
    return this.redis.hGet(USERS_COLLECTION, userId);
  }

  async getUserInfo(userId: string) {
    const data = await this.redis.hGetAll(this.getUserInfoKey(userId));
    const user = Object.assign(new UserEntity(), {
      ...data,
      rooms: data.rooms?.split(','),
    });
    return user;
  }

  // Keep track of room's members
  async addUserToRoom(room: string, userId: string) {
    return this.redis.sAdd(this.getRoomKey(room), userId);
  }

  removeUserFromRoom(room: string, userId: string) {
    return this.redis.sRem(this.getRoomKey(room), userId);
  }

  async getRoomMembers(room: string): Promise<UserEntity[]> {
    const userIDS = await this.redis.sMembers(this.getRoomKey(room));
    const users = [];
    for await (const userId of userIDS) {
      users.push(await this.getUserInfo(userId));
    }
    return users;
  }

  // For testing TODO: remove later
  async getAllUsers() {
    const g = await this.redis.hGetAll(USERS_COLLECTION);
    return g;
  }

  onDestroy() {
    this.redis.quit();
  }
}
