import { HttpException, UseFilters } from '@nestjs/common';
import { Args, Context, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Request, Response } from 'express';
import { HttpExceptionFilter } from 'src/http-exception-filter/http-exception-filter.filter';
import { AuthPayload, NewUserInput } from 'src/schema/graphql';
import { JWT_TOKEN, REFRESH_TOKEN } from 'src/types';
import { UserService } from 'src/user/user.service';
import { GraphResponse, TokenService } from 'src/utils';
import { AuthService } from './auth.service';
@Resolver('Auth')
@UseFilters(new HttpExceptionFilter())
export class AuthResolver {
  constructor(
    private authService: AuthService,
    private userService: UserService,
    private tokenService: TokenService,
  ) {}

  @Mutation('login')
  async logIn(
    @Args('email') email: string,
    @Args('password') password: string,
    @GraphResponse() res: Response,
  ): Promise<AuthPayload> {
    const authPayload = await this.authService.validateUser(email, password);

    if (!authPayload) {
      throw new HttpException(
        'Invalid credentials, User not found or password is incorrect',
        401,
      );
    }
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
    const userExists = await this.userService.userExists(data.email);
    if (userExists) {
      throw new HttpException('User already exists', 409);
    }

    const user = await this.userService.createUser(data);
    const jwt = this.tokenService.createToken(user);

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
    const { id } = await this.tokenService.validateRefreshToken(refreshToken);
    const user = await this.userService.getUserById(id);
    const jwt = this.tokenService.createToken(user);

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
