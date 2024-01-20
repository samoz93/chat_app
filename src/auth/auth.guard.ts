import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { GqlExecutionContext } from '@nestjs/graphql';
import { JwtService } from '@nestjs/jwt';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';
import { IS_PUBLIC_KEY } from './meta';

@Injectable()
export class MyAuthGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private jwtService: JwtService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // Check if the route is public
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (isPublic) return isPublic;

    const req = GqlExecutionContext.create(context).getContext().req as Request;
    const token = this.getToken(req.headers);

    if (!token) {
      throw new UnauthorizedException('No token provided');
    }

    try {
      const user = await this.jwtService.verifyAsync<UserEntity>(token, {
        secret: CONFIG.jwtSecret,
      });
      req['user'] = user;
    } catch (error) {
      throw new UnauthorizedException('Invalid token');
    }

    return true;
  }

  getToken = (headers: any) => {
    const [type, token] = (headers.authorization ?? '').split(' ');
    return type === 'Bearer' ? token : null;
  };
}
