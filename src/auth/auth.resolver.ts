import { HttpException } from '@nestjs/common';
import { Args, Context, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Request, Response } from 'express';
import { AuthPayload, NewUserInput } from 'src/schema/graphql';
import { JWT_TOKEN, REFRESH_TOKEN } from 'src/types';
import { UserService } from 'src/user/user.service';
import { GraphResponse, createToken, validateRefreshToken } from 'src/utils';
import { AuthService } from './auth.service';
@Resolver('Auth')
// @UseFilters(new HttpExceptionFilter())
export class AuthResolver {
  constructor(
    private authService: AuthService,
    private userService: UserService,
  ) {}

  @Mutation('login')
  async logIn(
    @Args('email') email: string,
    @Args('password') password: string,
    @GraphResponse() res: Response,
  ): Promise<AuthPayload> {
    const authPayload = await this.authService.validateUser(email, password);

    res.cookie(REFRESH_TOKEN, authPayload.refreshToken);
    res.cookie(JWT_TOKEN, authPayload.token);

    return {
      token: authPayload.token,
      user: authPayload.user,
    };
  }

  @Mutation('signUp')
  async signup(
    @Args('data') data: NewUserInput,
    @GraphResponse() res: Response,
  ): Promise<AuthPayload> {
    const user = await this.userService.createUser(data);
    const jwt = createToken(user);

    res.cookie(REFRESH_TOKEN, jwt.refreshToken);
    res.cookie(JWT_TOKEN, jwt.token);
    return {
      user,
      token: jwt.token,
    };
  }

  @Query('refresh')
  async refreshToken(
    @Context('req') req: Request,
    @GraphResponse() res: Response,
  ): Promise<AuthPayload> {
    const refreshToken = req.cookies[REFRESH_TOKEN];

    if (!refreshToken) {
      throw new HttpException('Invalid refresh token', 401);
    }
    const { id } = await validateRefreshToken(refreshToken);
    const user = await this.userService.getUserById(id);
    const jwt = createToken(user);

    res.cookie(REFRESH_TOKEN, jwt.refreshToken);
    res.cookie(JWT_TOKEN, jwt.token);

    return {
      user,
      token: jwt.token,
    };
  }

  @Query('test')
  async test(): Promise<any> {
    return this.userService.getAllUsers();
  }
}
