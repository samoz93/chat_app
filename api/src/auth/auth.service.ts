import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { UserEntity } from 'src/entities/user.entity';
import { AuthPayload } from 'src/schema/graphql';
import { TokenService } from 'src/shared/token.service';
import { sanitizeUser } from 'src/utils';
import { Repository } from 'typeorm';
@Injectable()
export class AuthService {
  constructor(
    @InjectRepository(UserEntity)
    private userEntity: Repository<UserEntity>,
    private tokenService: TokenService,
  ) {}

  async validateUser(
    email: string,
    pass: string,
  ): Promise<AuthPayload & { refreshToken: string }> {
    const user = await this.userEntity.findOneBy({
      email,
    });
    if (user && user.password === pass) {
      const sanitizedUser = sanitizeUser(user);
      const jwt = this.tokenService.createToken(sanitizedUser);

      return {
        refreshToken: jwt.refreshToken,
        token: jwt.token,
        user: sanitizedUser,
      };
    }
  }
}
