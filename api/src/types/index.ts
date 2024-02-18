import { UserEntity } from 'src/entities/user.entity';
import { User } from 'src/schema/graphql';

export type MyRequest = Request & { user: UserEntity };

interface ICommon {
  id?: string;
}
interface IMessage extends ICommon {
  message: string;
  sender: User | 'admin';
  createdAt?: number;
}

export interface IoRoomMessage extends IMessage {
  room?: string;
}

export interface IoPrivateMessage extends IMessage {
  receiver?: string;
}

export interface IoMessageEnterOrExit extends ICommon {
  room: string;
  users: UserEntity[];
}

export interface IoNewFriend {
  user: UserEntity;
}

export type ServerToClientTypes = {
  newMessage: (opt: IoRoomMessage) => void;
  newPrivateMessage: (opt: IoPrivateMessage) => void;
  roomEvents: (opt: IoMessageEnterOrExit) => void;
  newRoom: (opt: string) => void;
  removeRoom: (opt: string) => void;
  unreadPrivateMessages: (opt: IoPrivateMessage[]) => void;
  onNewFriend: (opt: IoNewFriend) => void;
};

export const REFRESH_TOKEN = 'refreshToken';
export const JWT_TOKEN = 'jwt_token';
