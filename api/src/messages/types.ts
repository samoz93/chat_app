import { Socket } from 'socket.io';
import { UserEntity } from 'src/entities/user.entity';

export type SocketWithUser = Socket & { user: UserEntity };
