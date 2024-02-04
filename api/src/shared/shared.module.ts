import { Module } from '@nestjs/common';
import { RedisService } from 'src/user/redis.service';
import { TokenService } from 'src/utils';

@Module({
  providers: [
    TokenService,
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
  exports: [TokenService, RedisService],
})
export class SharedModule {}
