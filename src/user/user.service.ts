import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import * as _ from 'lodash';
import { UserEntity } from 'src/entities/user.entity';
import { Repository } from 'typeorm';

@Injectable()
export class UserService {
  private sanitizeUser(user: UserEntity) {
    return _.omit(user, ['password']);
  }

  constructor(
    @InjectRepository(UserEntity)
    private userEntity: Repository<UserEntity>,
  ) {}

  getUserByEmail(email: string) {
    return this.userEntity
      .findOneBy({
        email,
      })
      .then(this.sanitizeUser);
  }

  getAllUsers() {
    return this.userEntity.find({
      select: ['id', 'email', 'name', 'createdAt'],
    });
  }

  getUserById(id: string) {
    return this.userEntity
      .findOneBy({
        id,
      })
      .then(this.sanitizeUser);
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
    return this.userEntity.save(data).then(this.sanitizeUser);
  }
}
