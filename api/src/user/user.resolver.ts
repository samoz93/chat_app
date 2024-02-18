import { UseGuards } from '@nestjs/common';
import { Args, Query, Resolver } from '@nestjs/graphql';
import { GQAuthGuard } from 'src/auth/auth.guard';
import { UserEntity } from 'src/entities/user.entity';
import { User } from 'src/utils';
import { UserService } from './user.service';

@Resolver('User')
@UseGuards(GQAuthGuard)
export class UserResolver {
  constructor(private service: UserService) {}

  @Query('user')
  async getUser(@Args('id') id: string) {
    return this.service.getUserById(id);
  }

  @Query('getFriends')
  async getFriends(@User() user: UserEntity) {
    return this.service
      .getUserWithRelations(user.id)
      .then((user) => user.friends);
  }
}
