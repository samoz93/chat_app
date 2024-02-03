import { Test, TestingModule } from '@nestjs/testing';
import { getRepositoryToken } from '@nestjs/typeorm';
import * as _ from 'lodash';
import { UserEntity } from 'src/entities/user.entity';
import { MockUsers } from 'src/test_utils/constants';
import { Repository } from 'typeorm';
import { UserService } from './user.service';

describe('UserService', () => {
  let service: UserService;
  const testUser = MockUsers[0];
  let repo: Repository<UserEntity>;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        UserService,
        {
          provide: getRepositoryToken(UserEntity),
          useValue: {
            findOneBy: jest.fn(async (id) => testUser),
            find: jest.fn(async ({ select }: { select: string[] }) => {
              return [_.pick(testUser, select)];
            }),
            create: jest.fn(async (ent) => ent),
            save: jest.fn(async (ent) => ent),
          },
        },
      ],
    }).compile();

    service = module.get<UserService>(UserService);
    repo = module.get(getRepositoryToken(UserEntity));
  });

  it('User Service should be defined', async () => {
    expect(service).toBeDefined();
  });

  it('Should be able to create a user', async () => {
    const user = await service.createUser(testUser);
    expect(user).toBeDefined();
    expect(user).not.toHaveProperty('password');
    expect(user.email).toBe(testUser.email);
    expect(user.name).toBe(testUser.name);
    expect(repo.create).toHaveBeenCalledTimes(1);
    expect(repo.save).toHaveBeenCalledTimes(1);
  });

  it('Should be able to get a user by id', async () => {
    const user = await service.getUserById(testUser.id);
    expect(user).toBeDefined();
    expect(user).not.toHaveProperty('password');
    expect(user.email).toBe(testUser.email);
    expect(user.name).toBe(testUser.name);
    expect(repo.findOneBy).toHaveBeenCalledTimes(1);
  });

  it('Should be able to get a user by email', async () => {
    const user = await service.getUserByEmail(testUser.id);
    expect(user).toBeDefined();
    expect(user).not.toHaveProperty('password');
    expect(user.email).toBe(testUser.email);
    expect(user.name).toBe(testUser.name);
    expect(repo.findOneBy).toHaveBeenCalledTimes(1);
  });

  it('Should be able to get all users', async () => {
    const users = await service.getAllUsers();
    expect(users).toBeDefined();
    expect(users.length).toBe(1);
    expect(repo.find).toHaveBeenCalledTimes(1);
    users.forEach((user) => {
      expect(user).toBeDefined();
      expect(user).not.toHaveProperty('password');
    });
  });
});
