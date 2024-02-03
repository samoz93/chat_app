import { MockUsers } from './constants';

export const UserServiceMockFactory = jest.fn(() => ({
  getUserById: jest.fn(async (id) => MockUsers[0]),
  deleteUser: jest.fn(async (id) => MockUsers[0]),
}));
