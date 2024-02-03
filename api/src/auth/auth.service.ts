import { HttpException, Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UserEntity } from 'src/entities/user.entity';
import { AuthPayload } from 'src/schema/graphql';
import { createToken, sanitizeUser } from 'src/utils';
import { Repository } from 'typeorm';
@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(UserEntity)
    private userEntity: Repository<UserEntity>,
  ) {}

  async validateUser(
    email: string,
    pass: string,
  ): Promise<AuthPayload & { refreshToken: string }> {
    const user = await this.userEntity.findOneBy({
      email,
    });
    if (user && user.password === pass) {
      const sanitizedUser = sanitizeUser(user);
      const jwt = createToken(sanitizedUser);

      return {
        refreshToken: jwt.refreshToken,
        token: jwt.token,
        user: sanitizedUser,
      };
    }

    throw new HttpException(
      'Invalid credentials, User not found or password is incorrect',
      401,
    );
  }
}
