import { UserEntity } from 'src/entities/user.entity';

export type MyRequest = Request & { user: UserEntity };

export type ServerToClientTypes = {
  newMessage: (opt: { message: string; sender: string }) => void;
};

export const REFRESH_TOKEN = 'refreshToken';
export const JWT_TOKEN = 'jwt_token';
