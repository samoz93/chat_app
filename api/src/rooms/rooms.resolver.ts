import { UseGuards } from '@nestjs/common';
import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import { GQAuthGuard } from 'src/auth/auth.guard';
import { RoomEntity } from 'src/entities/room.entity';
import { UserEntity } from 'src/entities/user.entity';
import { User } from 'src/utils';
import { RoomsService } from './rooms.service';

@Resolver()
@UseGuards(GQAuthGuard)
export class RoomsResolver {
  constructor(private service: RoomsService) {}

  @Mutation('createRoom')
  async createRoom(
    @Args('name') name: string,
    @Args('description') description: string,
    @User() user: UserEntity,
  ) {
    const data = await this.service.createRoom(name, description, user);
    return data;
  }

  @Query('getRooms')
  async getRooms(
    @Args('page') page: number,
    @Args('limit') limit: number,
  ): Promise<RoomEntity[]> {
    return await this.service.getRooms(page, limit);
  }
}
