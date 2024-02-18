import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { RoomEntity } from 'src/entities/room.entity';
import { UserEntity } from 'src/entities/user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class RoomsService {
  constructor(
    @InjectRepository(RoomEntity) private repo: Repository<RoomEntity>,
  ) {}

  async createRoom(name: string, description: string, owner: UserEntity) {
    const room = await this.repo.save({
      name,
      description,
      owner: owner,
      users: [owner],
    });
    await this.repo.save(room);
    return room;
  }

  async getRooms(page: number = 0, limit: number = 10) {
    return await this.repo.find({
      take: limit,
      skip: page * limit,
      order: { createdAt: 'DESC' },
    });
  }
}
