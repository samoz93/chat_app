import { Injectable } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';
import { CustomUnauthorizedException } from 'src/errors';
import { to } from 'src/utils';
import { UserService } from './user.service';

@Injectable()
export class TokenService {
  constructor(private userService: UserService) {}
  private jwtService = new JwtService({
    secret: CONFIG.jwtSecret,
    global: true,
    signOptions: { expiresIn: '1d' },
  });

  private jwtRefreshService = new JwtService({
    secret: CONFIG.jwtSecret,
    global: true,
    signOptions: { expiresIn: '7d' },
  });

  validateToken = async (headers: any) => {
    const [type, token] = (headers.authorization ?? '').split(' ');
    const tokenString = type === 'Bearer' ? token : null;
    if (!tokenString) {
      throw new CustomUnauthorizedException(
        "Token wasn't provided or is invalid. Please provide a valid token.",
      );
    }

    const [err, user] = await to(
      this.jwtService.verifyAsync<UserEntity>(tokenString),
    );

    if (err) {
      throw new CustomUnauthorizedException(
        'Invalid token, unexpected error while verifying token',
      );
    }
    if (!user) {
      throw new CustomUnauthorizedException('Invalid token, no user found');
    }

    return await this.userService.getUserById(user.id);
  };

  validateRefreshToken = async (tokenString: string) => {
    const [err, data] = await to(
      this.jwtRefreshService.verifyAsync<{
        id: string;
      }>(tokenString),
    );

    if (err) {
      throw new CustomUnauthorizedException(err);
    }

    if (!data) {
      throw new CustomUnauthorizedException('Invalid token, no data found');
    }
    return data;
  };

  createToken = (user: UserEntity | Partial<UserEntity>) => {
    const token = this.jwtService.sign({ ...user });
    const refreshToken = this.jwtRefreshService.sign({ id: user.id });
    return { token, refreshToken };
  };
}
