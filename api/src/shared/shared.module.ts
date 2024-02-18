import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RoomEntity } from 'src/entities/room.entity';
import { UserEntity } from 'src/entities/user.entity';
import { RedisService } from 'src/user/redis.service';
import { UserService } from 'src/user/user.service';
import { TokenService } from './token.service';

@Module({
  imports: [TypeOrmModule.forFeature([UserEntity, RoomEntity])],
  providers: [
    TokenService,
    UserService,
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
  exports: [TokenService, RedisService, TypeOrmModule],
})
export class SharedModule {}
