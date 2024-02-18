import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import to from 'await-to-js';
import { RoomEntity } from 'src/entities/room.entity';
import { UserEntity } from 'src/entities/user.entity';
import { DatabaseError } from 'src/errors';
import { Repository } from 'typeorm';

@Injectable()
export class RoomsService {
  constructor(
    @InjectRepository(RoomEntity) private repo: Repository<RoomEntity>,
  ) {}

  async createRoom(name: string, description: string, owner: UserEntity) {
    const [err, room] = await to(
      this.repo.save({
        name,
        description,
        owner: owner,
        users: [owner],
      }),
    );
    if (err) throw new DatabaseError(err, { name, description, owner });

    return room;
  }

  async getRoomById(id: string) {
    const [err, data] = await to(this.repo.findOne({ where: { id } }));

    if (err) throw new DatabaseError(err, { id });

    return data;
  }

  async getRooms(page: number = 0, limit: number = 10) {
    const [err, data] = await to(
      this.repo.find({
        take: limit,
        skip: page * limit,
        order: { createdAt: 'DESC' },
      }),
    );

    if (err) throw new DatabaseError(err, { page, limit });

    return data;
  }
}
