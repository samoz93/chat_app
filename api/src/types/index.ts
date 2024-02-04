import { UserEntity } from 'src/entities/user.entity';

export type MyRequest = Request & { user: UserEntity };

export interface IoMessage {
  message: string;
  sender: string;
  receiver: string;
  room?: string;
}
export type ServerToClientTypes = {
  newMessage: (opt: IoMessage) => void;
};

export const REFRESH_TOKEN = 'refreshToken';
export const JWT_TOKEN = 'jwt_token';
