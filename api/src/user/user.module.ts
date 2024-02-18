import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { UserResolver } from './user.resolver';

@Module({
  imports: [SharedModule],
  providers: [UserResolver],
  exports: [],
})
export class UserModule {}
