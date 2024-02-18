import { Module } from '@nestjs/common';
import { SharedModule } from 'src/shared/shared.module';
import { RoomsResolver } from './rooms.resolver';
import { RoomsService } from './rooms.service';

@Module({
  imports: [SharedModule],
  providers: [RoomsResolver, RoomsService],
})
export class RoomsModule {}
