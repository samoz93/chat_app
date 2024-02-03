import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import { UserEntity } from 'src/entities/user.entity';
import { MockUsers } from 'src/test_utils/constants';
import { Repository } from 'typeorm';
import { AuthService } from './auth.service';

describe('AuthService', () => {
  let service: AuthService;
  const testUser = MockUsers[0];
  let repo: Repository<UserEntity>;
  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        AuthService,
        {
          provide: getRepositoryToken(UserEntity),
          useValue: {
            findOneBy: jest.fn(async (id) => testUser),
          },
        },
      ],
    }).compile();

    service = module.get<AuthService>(AuthService);
    repo = module.get(getRepositoryToken(UserEntity));
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  it('Expect to have a jwt token', async () => {
    const user = await service.validateUser(testUser.email, testUser.password);
    expect(user).toBeDefined();
    expect(repo.findOneBy).toHaveBeenCalledTimes(1);
    expect(user.token).toBeDefined();
    expect(user.refreshToken).toBeDefined();
  });

  it('Expect to Fail validation with different password', async () => {
    jest.spyOn(repo, 'findOneBy').mockImplementation(async () => ({
      ...testUser,
      password: 'notTheSame',
    }));
    try {
      await service.validateUser(testUser.email, 'different');
      expect(true).toBe(false);
    } catch (error) {
      expect(error).toBeDefined();
    }
  });
});
