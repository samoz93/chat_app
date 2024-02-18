import { CanActivate, ExecutionContext, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { GqlExecutionContext } from '@nestjs/graphql';
import { TokenService } from 'src/shared/token.service';
import { IS_PUBLIC_KEY } from './meta';

@Injectable()
export class GQAuthGuard implements CanActivate {
  constructor(
    private reflector: Reflector,
    private tokenService: TokenService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    // Check if the route is public
    const isPublic = this.reflector.getAllAndOverride<boolean>(IS_PUBLIC_KEY, [
      context.getHandler(),
      context.getClass(),
    ]);

    if (isPublic) return isPublic;

    const req = GqlExecutionContext.create(context).getContext().req as Request;
    req['user'] = await this.tokenService.validateToken(req.headers);

    return true;
  }
}
