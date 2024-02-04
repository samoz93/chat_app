import { createMock } from '@golevelup/ts-jest';
import { HttpException } from '@nestjs/common';
import { Test, TestingModule } from '@nestjs/testing';
import { Response } from 'express';
import { MockUsers } from 'src/test_utils/constants';
import {
  TokenServiceMockFactory,
  UserServiceMockFactory,
} from 'src/test_utils/userService.mock';
import { UserService } from 'src/user/user.service';
import { TokenService } from 'src/utils';
import { AuthResolver } from './auth.resolver';
import { AuthService } from './auth.service';

describe('AuthResolver', () => {
  const user = MockUsers[0];

  let resolver: AuthResolver;
  let authService: AuthService;
  let userService: UserService;
  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthResolver,
        {
          provide: UserService,
          useFactory: UserServiceMockFactory,
        },
        {
          provide: AuthService,
          useFactory: () => {
            return {
              validateUser: jest.fn(async () => ({
                user,
                token: 'token',
                refreshToken: 'refreshToken',
              })),
            };
          },
        },
        {
          provide: TokenService,
          useFactory: TokenServiceMockFactory,
        },
      ],
    }).compile();
    resolver = module.get<AuthResolver>(AuthResolver);
    authService = module.get<AuthService>(AuthService);
    userService = module.get<UserService>(UserService);
  });
  it('should be defined', async () => {
    expect(resolver).toBeDefined();
  });
  it('Should be able to register a user', async () => {
    const mock = createMock<Response>({});
    jest.spyOn(userService, 'userExists').mockImplementation(async () => false);
    const result = await resolver.signup(user, mock as Response<any, any>);

    expect(result).toBeDefined();
    expect(result).toHaveProperty('token');
    expect(result).toHaveProperty('user');
    expect(userService.userExists).toHaveBeenCalledWith(user.email);
    expect(mock.cookie).toHaveBeenCalledTimes(2);
    expect(result.user.email).toEqual(user.email);
  });

  it('Should throw an error if user already exists', async () => {
    const mock = createMock<Response>({});
    jest.spyOn(userService, 'userExists').mockImplementation(async () => true);
    try {
      await resolver.signup(user, mock as Response<any, any>);
      expect(true).toBe(false);
    } catch (error) {
      expect(error).toBeDefined();
    }
  });

  it('Should be able to login', async () => {
    const mock = createMock<Response>({});
    const result = await resolver.logIn(
      user.email,
      user.password,
      mock as Response<any, any>,
    );

    expect(result).toBeDefined();
    expect(result).toHaveProperty('token');
    expect(result).toHaveProperty('user');
    expect(authService.validateUser).toHaveBeenCalledWith(
      user.email,
      user.password,
    );
    expect(result.user.email).toEqual(user.email);
    expect(mock.cookie).toHaveBeenCalledTimes(2);
  });

  it('Throws an exception if user does not exist', async () => {
    const mock = createMock<Response>({});
    jest
      .spyOn(authService, 'validateUser')
      .mockImplementation(async () => null);
    try {
      await resolver.logIn(
        user.email,
        user.password,
        mock as Response<any, any>,
      );
      expect(true).toBe(false);
    } catch (error) {
      expect(error).toBeDefined();
      expect(error).toBeInstanceOf(HttpException);
      expect(error.getStatus()).toBe(401);
    }
  });
});
