import { ExecutionContext, createParamDecorator } from '@nestjs/common';
import { GqlExecutionContext } from '@nestjs/graphql';
import { UserEntity } from 'src/entities/user.entity';

export const User = createParamDecorator(
  (data: keyof Exclude<UserEntity, 'password'>, ctx: ExecutionContext) => {
    const type = ctx.getType() as string;
    if (type === 'graphql') {
      const request = GqlExecutionContext.create(ctx).getContext().req;
      if (data) return request.user[data];
      return request.user;
    }
    if (ctx.getType() === 'ws') {
      const socket = ctx.switchToWs().getClient();
      return socket.user;
    }

    if (ctx.getType() === 'http') {
      const request = ctx.switchToHttp().getRequest();
      return request.user;
    }

    return {};
  },
);

export const GraphResponse = createParamDecorator(
  (data: keyof Exclude<UserEntity, 'password'>, ctx: ExecutionContext) => {
    const type = ctx.getType() as string;
    if (type === 'graphql') {
      const context = GqlExecutionContext.create(ctx).getContext();
      const req = context.req;
      return req.res;
    }
    return {};
  },
);

export const GraphRequest = createParamDecorator(
  (data: keyof Exclude<UserEntity, 'password'>, ctx: ExecutionContext) => {
    const type = ctx.getType() as string;
    if (type === 'graphql') {
      const context = GqlExecutionContext.create(ctx).getContext();
      const req = context.req;
      return req;
    }
    return {};
  },
);
