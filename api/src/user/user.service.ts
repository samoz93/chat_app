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
    else user.rooms.push(room);

    await this.userEntity.save(user);
  }

  async removeRoomFromUser(userId: string, roomId: string) {
    const user = await this.userEntity.findOneBy({ id: userId });
    const room = await this.roomRepo.findOneBy({ id: roomId });
    if (!user || !room) {
      throw new Error('User or room not found');
    }

    user.rooms = user.rooms.filter((r) => r.id !== room.id);

    await this.userEntity.save(user);
  }

  async getUserById(id: string) {
    return this.userEntity
      .findOneBy({
        id,
      })
      .then(sanitizeUser);
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
}
