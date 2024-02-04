import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { MessagesGateway } from './messages.gateway';

@Module({
  imports: [SharedModule],
  providers: [MessagesGateway],
})
export class MessagesModule {}
