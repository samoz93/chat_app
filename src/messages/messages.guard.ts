import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Socket } from 'socket.io';
import { validateToken } from '../utils';

@Injectable()
export class MessagesGuard implements CanActivate {
  async canActivate(context: ExecutionContext) {
    const socket = context.switchToWs().getClient() as Socket;
    const user = await validateToken(socket.handshake.headers);

    if (!user) {
      throw new UnauthorizedException('Invalid token');
    }

    return true;
  }
}

export const SocketAuthMiddleWare = async (socket: Socket, next) => {
  try {
    const user = await validateToken(socket.handshake.headers);
    socket['user'] = user; // socket['user'] = socket.user = user
    next();
  } catch (error) {
    next(new UnauthorizedException('Invalid token'));
  }
};
