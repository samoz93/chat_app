import { UserEntity } from 'src/entities/user.entity';

export type MyRequest = Request & { user: UserEntity };

interface ICommon {
  type: 'join' | 'leave' | 'message';
  id?: string;
}
export interface IoMessage extends ICommon {
  message: string;
  sender: string;
  receiver: string;
  room?: string;
  createdAt?: number;
}
export interface IoMessageEnterOrExit extends ICommon {
  room: string;
  users: UserEntity[];
}

export type ServerToClientTypes = {
  newMessage: (opt: IoMessage) => void;
  roomEvents: (opt: IoMessageEnterOrExit) => void;
  newRoom: (opt: string) => void;
  removeRoom: (opt: string) => void;
};

export const REFRESH_TOKEN = 'refreshToken';
export const JWT_TOKEN = 'jwt_token';
