import { createParamDecorator, ExecutionContext } from '@nestjs/common';
import { GqlExecutionContext } from '@nestjs/graphql';
import { UserEntity } from 'src/entities/user.entity';

export const User = createParamDecorator(
  (data: keyof Exclude<UserEntity, 'password'>, ctx: ExecutionContext) => {
    const request = GqlExecutionContext.create(ctx).getContext().req;
    if (data) return request.user[data];
    return request.user;
  },
);
