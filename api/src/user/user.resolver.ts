import { UseFilters, UseGuards } from '@nestjs/common';
import { Args, Query, Resolver } from '@nestjs/graphql';
import { GQAuthGuard } from 'src/auth/auth.guard';
import { UserEntity } from 'src/entities/user.entity';
import { HttpExceptionFilter } from 'src/http-exception-filter/http-exception-filter.filter';
import { UserService } from 'src/services';
import { User, sanitizeUser } from 'src/utils';

@Resolver('User')
@UseGuards(GQAuthGuard)
@UseFilters(HttpExceptionFilter)
export class UserResolver {
  constructor(private service: UserService) {}

  @Query('user')
  async getUser(@Args('id') id: string) {
    return this.service.getUserById(id).then(sanitizeUser);
  }

  @Query('getFriends')
  async getFriends(@User() user: UserEntity) {
    return this.service
      .getUserById(user.id, { friends: true })
      .then((user) => user.friends);
  }
}
