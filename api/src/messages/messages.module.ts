import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { MessagesGateway } from './messages.gateway';
import { RoomClientService } from './room.client/room.client.service';

@Module({
  imports: [SharedModule],
  providers: [MessagesGateway, RoomClientService],
})
export class MessagesModule {}
