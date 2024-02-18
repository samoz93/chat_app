import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { UserResolver } from './user.resolver';
import { UserService } from './user.service';

@Module({
  imports: [SharedModule],
  providers: [UserResolver, UserService],
  exports: [UserService],
})
export class UserModule {}
