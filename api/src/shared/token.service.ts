import { Injectable, UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';
import { UserService } from 'src/user/user.service';

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
    let user: UserEntity;

    const tokenString = type === 'Bearer' ? token : null;
    if (!tokenString) {
      throw new UnauthorizedException('No token provided');
    }

    try {
      user = await this.jwtService.verifyAsync<UserEntity>(tokenString);
      return await this.userService.getUserById(user.id);
    } catch (error) {
      throw new UnauthorizedException('Invalid token');
    }
  };

  validateRefreshToken = async (tokenString: string) => {
    try {
      const data = await this.jwtRefreshService.verifyAsync<{ id: string }>(
        tokenString,
      );

      if (!data) {
        throw new UnauthorizedException('Invalid token');
      }
      return data;
    } catch (error) {
      throw new UnauthorizedException('Invalid token');
    }
  };

  createToken = (user: UserEntity | Partial<UserEntity>) => {
    const token = this.jwtService.sign({ ...user });
    const refreshToken = this.jwtRefreshService.sign({ id: user.id });
    return { token, refreshToken };
  };
}
