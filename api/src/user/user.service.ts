import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { RoomEntity } from 'src/entities/room.entity';
import { UserEntity } from 'src/entities/user.entity';
import { sanitizeUser } from 'src/utils';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(UserEntity)
    private userEntity: Repository<UserEntity>,
    @InjectRepository(RoomEntity)
    private roomRepo: Repository<RoomEntity>,
  ) {}

  async getUserByEmail(email: string) {
    return this.userEntity
      .findOneBy({
        email,
      })
      .then(sanitizeUser);
  }

  getAllUsers() {
    return this.userEntity.find({
      select: ['id', 'email', 'name', 'createdAt'],
    });
  }

  async addRoomToUser(userId: string, roomId: string) {
    const user = await this.userEntity.findOneBy({ id: userId });
    const room = await this.roomRepo.findOne({ where: { id: roomId } });

    if (!user || !room) {
      throw new Error('User or room not found');
    }
    if (!user.rooms) user.rooms = [room];
    else {
      if (user.rooms!.filter((e) => e.id === roomId)) return user;
      user.rooms.push(room);
    }

    return await this.userEntity.save(user);
  }

  async removeRoomFromUser(userId: string, roomId: string) {
    const user = await this.userEntity.findOneBy({ id: userId });
    const room = await this.roomRepo.findOneBy({ id: roomId });
    if (!user || !room) {
      throw new Error('User or room not found');
    }

    user.rooms = user.rooms?.filter((r) => r.id !== room.id) ?? [];

    await this.userEntity.save(user);
  }

  addFriend = async (userId: string, friendId: string) => {
    const user1 = await this.getUserWithRelations(userId);
    const user2 = await this.userEntity.findOneBy({
      id: friendId,
    });

    if (user1.friends?.find((f) => f.id === friendId)) {
      return;
    }

    if (!user1 || !user2) {
      throw new Error("Can't find the people you're searching for");
    }

    await this.userEntity.manager.transaction(async (entity) => {
      console.log('user1', user1.friends);

      user1.friends = Array.from(new Set([...(user1.friends ?? []), user2]));
      user2.friends = Array.from(new Set([...(user2.friends ?? []), user1]));
      await entity.save(user1);
      await entity.save(user2);
    });

    return [user1, user2];
  };

  async getUserById(id: string) {
    const data = await this.userEntity.findOneBy({
      id,
    });
    return sanitizeUser(data);
  }

  deleteUser(id: string) {
    return this.userEntity.delete({
      id,
    });
  }

  async createUser({
    name,
    password,
    email,
  }: {
    email: string;
    name: string;
    password: string;
  }) {
    const data = this.userEntity.create({
      email,
      name,
      password,
      rooms: [],
    });

    const newData = await this.userEntity.save(data).then(sanitizeUser);

    return newData;
  }

  async userExists(email: string) {
    return this.userEntity.findOneBy({ email }).then((user) => !!user);
  }

  async getUserWithRelations(userId: string) {
    const user = await this.userEntity.find({
      relations: ['friends', 'rooms'],
      where: {
        id: userId,
      },
    });

    return user[0];
  }
}
