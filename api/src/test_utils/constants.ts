import { UserEntity } from 'src/entities/user.entity';

export const MockUsers: UserEntity[] = [
  {
    email: 'test@test.com',
    name: 'test',
    id: 'test',
    password: 'test',
    updatedAt: new Date(),
    createdAt: new Date(),
    ownedRooms: [],
  },
];
