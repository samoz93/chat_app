import {
  HttpException,
  UnauthorizedException,
  UseFilters,
} from '@nestjs/common';
import { Args, Mutation, Query, Resolver } from '@nestjs/graphql';
import { Response } from 'express';
import { HttpExceptionFilter } from 'src/http-exception-filter/http-exception-filter.filter';
import { AuthPayload, NewUserInput } from 'src/schema/graphql';
import { TokenService, UserService } from 'src/services';
import { JWT_TOKEN, REFRESH_TOKEN } from 'src/types';
import { GraphResponse, sanitizeUser } from 'src/utils';
import { AuthService } from './auth.service';
@Resolver('Auth')
@UseFilters(HttpExceptionFilter)
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

    res.cookie(REFRESH_TOKEN, authPayload.refreshToken);
    res.cookie(JWT_TOKEN, authPayload.token);

    return {
      ...authPayload,
    };
  }

  @Mutation('signUp')
  async signup(
    @Args('data') data: NewUserInput,
    @GraphResponse() res: Response,
  ): Promise<AuthPayload> {
    const userExists = await this.userService.userExists(data.email);

    // TODO: create a new error for this ? auth error maybe ?
    if (userExists) {
      throw new UnauthorizedException('User already exists');
    }

    const user = await this.userService.createUser(data).then(sanitizeUser);
    const jwt = this.tokenService.createToken(user);

    res.cookie(REFRESH_TOKEN, jwt.refreshToken);
    res.cookie(JWT_TOKEN, jwt.token);

    return {
      user,
      ...jwt,
    };
  }

  @Query('refresh')
  async refreshToken(
    @Args('refreshToken') refreshToken: string,
    @GraphResponse() res: Response,
  ): Promise<AuthPayload> {
    if (!refreshToken) {
      throw new HttpException('Invalid refresh token', 401);
    }

    const { id } = await this.tokenService.validateRefreshToken(refreshToken);
    const user = await this.userService.getUserById(id).then(sanitizeUser);

    const jwt = this.tokenService.createToken(user);

    res.cookie(REFRESH_TOKEN, jwt.refreshToken);
    res.cookie(JWT_TOKEN, jwt.token);

    return {
      user,
      ...jwt,
    };
  }
}
