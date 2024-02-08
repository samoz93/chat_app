import { Test, TestingModule } from '@nestjs/testing';
import { RoomClientService } from './room.client.service';

describe('RoomClientService', () => {
  let service: RoomClientService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [RoomClientService],
    }).compile();

    service = module.get<RoomClientService>(RoomClientService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
