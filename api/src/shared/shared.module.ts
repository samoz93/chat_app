import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RoomEntity } from 'src/entities/room.entity';
import { UserEntity } from 'src/entities/user.entity';
import { RoomsService } from 'src/rooms/rooms.service';
import { TokenService, UserService } from 'src/services';
import { RedisService } from 'src/user/redis.service';

@Module({
  imports: [TypeOrmModule.forFeature([UserEntity, RoomEntity])],
  providers: [
    TokenService,
    UserService,
    RoomsService,
    {
      provide: RedisService,
      useFactory: async () => {
        const redis = new RedisService();
        try {
          await redis.init();
        } catch (error) {
          console.error('Error initializing redis', error);
        }
        return redis;
      },
    },
  ],
  exports: [
    TokenService,
    RedisService,
    RoomsService,
    TypeOrmModule,
    UserService,
  ],
})
export class SharedModule {}
