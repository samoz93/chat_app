import { Module } from '@nestjs/common';
import { JwtModule } from '@nestjs/jwt';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CONFIG } from 'src/config';
import { UserEntity } from 'src/entities/user.entity';
import { UserModule } from 'src/user/user.module';
import { AuthController } from './auth.controller';
import { AuthResolver } from './auth.resolver';
import { AuthService } from './auth.service';

@Module({
  imports: [
    TypeOrmModule.forFeature([UserEntity]),
    UserModule,
    JwtModule.register({
      global: true,
      secret: CONFIG.jwtSecret,
      signOptions: { expiresIn: '60m' },
    }),
  ],
  providers: [AuthService, AuthResolver],
  controllers: [AuthController],
})
export class AuthModule {}
