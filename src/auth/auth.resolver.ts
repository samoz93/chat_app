import { HttpException } from '@nestjs/common';
import { Args, Mutation, Resolver } from '@nestjs/graphql';
import { JwtService } from '@nestjs/jwt';
import { CONFIG } from 'src/config';
import { AuthPayload } from 'src/schema/graphql';
import { UserService } from 'src/user/user.service';
import { AuthService } from './auth.service';
import { IsPublic } from './meta';

@Resolver('Auth')
export class AuthResolver {
  constructor(
    private authService: AuthService,
    private userService: UserService,
    private jwt: JwtService,
  ) {}

  @Mutation('login')
  @IsPublic()
  async logIn(
    @Args('email') email: string,
    @Args('password') password: string,
  ): Promise<AuthPayload> {
    const authPayload = await this.authService.validateUser(email, password);

    if (!authPayload) {
      throw new HttpException('Invalid credentials', 401);
    }

    return authPayload;
  }

  @Mutation('signUp')
  @IsPublic()
  async signup(
    @Args('email') email: string,
    @Args('name') name: string,
    @Args('password') password: string,
  ): Promise<AuthPayload> {
    const user = await this.userService.createUser({ email, name, password });
    const jwt = this.jwt.sign(
      { ...user },
      {
        secret: CONFIG.jwtSecret,
      },
    );

    return {
      user,
      token: jwt,
    };
  }
}
