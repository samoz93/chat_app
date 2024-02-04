import { Test, TestingModule } from '@nestjs/testing';
import { TokenServiceMockFactory } from 'src/test_utils/userService.mock';
import { TokenService } from 'src/utils';
import { MessagesGateway } from './messages.gateway';

describe('MessagesGateway', () => {
  let gateway: MessagesGateway;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MessagesGateway,
        {
          provide: TokenService,
          useFactory: TokenServiceMockFactory,
        },
      ],
    }).compile();

    gateway = module.get<MessagesGateway>(MessagesGateway);
  });

  it('should be defined', () => {
    expect(gateway).toBeDefined();
  });
});
