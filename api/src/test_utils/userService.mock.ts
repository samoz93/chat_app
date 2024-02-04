import { MockUsers } from './constants';

export const UserServiceMockFactory = jest.fn(() => ({
  getUserById: jest.fn(async (id) => MockUsers.find((user) => user.id === id)),
  deleteUser: jest.fn(async (id) => MockUsers.find((user) => user.id === id)),
  userExists: jest.fn(async (val: boolean) => val),
  createUser: jest.fn(async (user) => user),
}));

export const TokenServiceMockFactory = jest.fn(() => ({
  createToken: jest.fn(async (id) => ({
    token: 'token',
    refreshToken: 'refreshToken',
  })),
  validateRefreshToken: jest.fn(async (token) => MockUsers[0]),
  validateToken: jest.fn(async (token) => MockUsers[0]),
}));
