import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UserEntity } from 'src/entities/user.entity';
import { sanitizeUser } from 'src/utils';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
  constructor(
    @InjectRepository(UserEntity)
    private userEntity: Repository<UserEntity>,
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
    });

    const newData = await this.userEntity.save(data).then(sanitizeUser);

    return newData;
  }
}
