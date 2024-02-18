import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UserEntity } from 'src/entities/user.entity';
import { DatabaseError, NotFoundError } from 'src/errors';
import { RoomsService } from 'src/rooms/rooms.service';
import { to } from 'src/utils';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(UserEntity)
    private userEntity: Repository<UserEntity>,
    private roomService: RoomsService,
  ) {}

  async getUserByEmail(email: string) {
    const [err, data] = await to(
      this.userEntity.findOneBy({
        email,
      }),
    );
    if (err) throw new DatabaseError(err, { email });
    return data;
  }

  // TODO: remove later
  getAllUsers() {
    return this.userEntity.find({
      select: ['id', 'email', 'name', 'createdAt'],
    });
  }

  async addRoomToUser(userId: string, roomId: string) {
    const user = await this.getUserById(userId);
    const room = await this.roomService.getRoomById(roomId);

    if (!user || !room) {
      throw new NotFoundError({
        userId,
        roomId,
      });
    }

    if (!user.rooms) user.rooms = [room];
    else {
      if (user.rooms!.filter((e) => e.id === roomId)) return user;
      user.rooms.push(room);
    }

    const [err, data] = await to(this.userEntity.save(user));

    if (err) {
      throw new DatabaseError(err, { userId, roomId });
    }

    return data;
  }

  async removeRoomFromUser(userId: string, roomId: string) {
    const user = await this.getUserById(userId, {
      rooms: true,
    });

    const room = await this.roomService.getRoomById(roomId);

    if (!user || !room) {
      throw new NotFoundError({
        userId,
        roomId,
      });
    }

    user.rooms = user.rooms?.filter((r) => r.id !== room.id) ?? [];

    const [err, data] = await to(this.userEntity.save(user));

    if (err) throw new DatabaseError(err, { userId, roomId });

    return data;
  }

  addFriend = async (userId: string, friendId: string) => {
    const [err, user1] = await to(
      this.getUserById(userId, {
        friends: true,
      }),
    );

    if (err) throw err;

    const [err2, user2] = await to(
      this.getUserById(friendId, {
        friends: true,
      }),
    );

    if (err2) throw new DatabaseError(err2, { friendId });

    if (user1.friends?.find((f) => f.id === friendId)) {
      return;
    }

    // Can't happen i guess ?
    if (!user1 || !user2) {
      return;
    }

    const promise = this.userEntity.manager.transaction(async (entity) => {
      user1.friends = Array.from(new Set([...(user1.friends ?? []), user2]));
      user2.friends = Array.from(new Set([...(user2.friends ?? []), user1]));
      await entity.save(user1);
      await entity.save(user2);
    });

    const [err3] = await to(promise);

    if (err3) throw new DatabaseError(err3, { userId, friendId });

    return [user1, user2];
  };

  async getUserById(
    id: string,
    options?: {
      friends?: boolean;
      rooms?: boolean;
      ownedRooms?: boolean;
    },
  ) {
    const [err, data] = await to(
      this.userEntity.find({
        where: { id },
        relations: {
          friends: options?.friends ?? false,
          rooms: options?.rooms ?? false,
          ownedRooms: options?.ownedRooms ?? false,
        },
      }),
    );

    if (err) throw new DatabaseError(err, { id });

    return data.length > 0 ? data[0] : null;
  }

  async deleteUser(id: string) {
    const [err, data] = await to(
      this.userEntity.delete({
        id,
      }),
    );

    if (err) {
      throw new DatabaseError(err, { id });
    }

    return data;
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

    const [err, newData] = await to(this.userEntity.save(data));

    if (err) throw new DatabaseError(err, { email, name });

    return newData;
  }

  async userExists(email: string): Promise<boolean> {
    const [err, data] = await to(
      this.userEntity.findOneBy({ email }).then((user) => !!user),
    );
    if (err) {
      throw new DatabaseError(err, { email });
    }
    return data;
  }
}
