import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { UserModule } from 'src/user/user.module';
import { AuthResolver } from './auth.resolver';
import { AuthService } from './auth.service';

@Module({
  imports: [UserModule, SharedModule],
  providers: [AuthService, AuthResolver],
})
export class AuthModule {}
