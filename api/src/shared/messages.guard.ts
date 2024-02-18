import {
  CanActivate,
  ExecutionContext,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { Socket } from 'socket.io';
import { TokenService } from 'src/services';

@Injectable()
export class MessagesGuard implements CanActivate {
  constructor(private tokenService: TokenService) {}

  async canActivate(context: ExecutionContext) {
    const socket = context.switchToWs().getClient() as Socket;
    const user = await this.tokenService.validateToken(
      socket.handshake.headers,
    );

    if (!user) {
      throw new UnauthorizedException('Invalid token');
    }

    return true;
  }
}
