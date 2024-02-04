import { Injectable } from '@nestjs/common';
import { RedisClientType, createClient } from 'redis';
import { CONFIG } from 'src/config';

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

  async addUser(userId: string, clientId: string) {
    return await this.redis.hSet(USERS_COLLECTION, userId, clientId);
  }

  async userExists(userId: string) {
    return this.redis.hExists(USERS_COLLECTION, userId);
  }

  getUserClientId(userId: string) {
    return this.redis.hGet(USERS_COLLECTION, userId);
  }

  addToRoom(room: string, userId: string) {
    return this.redis.lPush(room, userId);
  }

  removeFromRoom(room: string, userId: string) {
    return this.redis.lRem(room, 0, userId);
  }

  getRoomMembers(room: string) {
    return this.redis.lRange(room, 0, -1);
  }

  async getAllUsers() {
    const g = await this.redis.hGetAll(USERS_COLLECTION);
    return g;
  }

  onDestroy() {
    this.redis.quit();
  }
}
