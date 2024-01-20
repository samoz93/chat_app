import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { InjectRepository } from '@nestjs/typeorm';
import * as _ from 'lodash';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';
import { AuthPayload } from 'src/schema/graphql';
import { Repository } from 'typeorm';

@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(UserEntity)
    private userEntity: Repository<UserEntity>,
    private jwt: JwtService,
  ) {}

  async validateUser(email: string, pass: string): Promise<AuthPayload> {
    const user = await this.userEntity.findOneBy({
      email,
    });
    if (user && user.password === pass) {
      const sanitizedUser = _.omit(user, ['password']);
      const jwt = this.jwt.sign(
        { ...sanitizedUser },
        {
          secret: CONFIG.jwtSecret,
        },
      );

      return {
        token: jwt,
        user: sanitizedUser,
      };
    }
    return null;
  }
}
