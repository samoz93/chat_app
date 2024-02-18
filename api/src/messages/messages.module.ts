import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { UserModule } from 'src/user/user.module';
import { MessagesGateway } from './messages.gateway';
import { RoomClientService } from './room.client.service';

@Module({
  imports: [SharedModule, UserModule],
  providers: [MessagesGateway, RoomClientService],
})
export class MessagesModule {}
