import { Test, TestingModule } from '@nestjs/testing';
import { MockUsers } from 'src/test_utils/constants';
import {
  TokenServiceMockFactory,
  UserServiceMockFactory,
} from 'src/test_utils/userService.mock';
import { TokenService } from 'src/utils';
import { UserResolver } from './user.resolver';
import { UserService } from './user.service';

describe('UserResolver', () => {
  let resolver: UserResolver;
  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserResolver,
        UserService,
        {
          provide: TokenService,
          useFactory: TokenServiceMockFactory,
        },
      ],
    })
      .overrideProvider(UserService)
      .useFactory({
        factory: UserServiceMockFactory,
      })
      .compile();
    resolver = module.get<UserResolver>(UserResolver);
  });
  it('should be defined', () => {
    expect(resolver).toBeDefined();
  });
  it('Can get a user', async () => {
    const user = await resolver.getUser('test');
    expect(user).toBeDefined();
    expect(user).toMatchObject(MockUsers[0]);
  });

  it('Can delete a user', async () => {
    const user = await resolver.deleteUser('test');
    expect(user).toBeDefined();
    expect(user).toMatchObject(MockUsers[0]);
  });
});
