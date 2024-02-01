import { UnauthorizedException } from '@nestjs/common';
import { JwtService } from '@nestjs/jwt';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';

const jwtService = new JwtService({
  secret: CONFIG.jwtSecret,
  global: true,
  signOptions: { expiresIn: '60m' },
});

const jwtRefreshService = new JwtService({
  secret: CONFIG.jwtSecret,
  global: true,
  signOptions: { expiresIn: '7d' },
});

export const validateToken = async (headers: any) => {
  const [type, token] = (headers.authorization ?? '').split(' ');
  let user: UserEntity;

  const tokenString = type === 'Bearer' ? token : null;
  if (!tokenString) {
    throw new UnauthorizedException('No token provided');
  }

  try {
    user = await jwtService.verifyAsync<UserEntity>(tokenString);
  } catch (error) {
    throw new UnauthorizedException('Invalid token');
  }

  return user;
};

export const validateRefreshToken = async (tokenString: string) => {
  try {
    const data = await jwtRefreshService.verifyAsync<{ id: string }>(
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

export const createToken = (user: UserEntity | Partial<UserEntity>) => {
  const token = jwtService.sign({ ...user });
  const refreshToken = jwtRefreshService.sign({ id: user.id });
  return { token, refreshToken };
};
