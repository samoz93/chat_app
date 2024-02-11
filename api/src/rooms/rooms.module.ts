import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { RoomEntity } from 'src/entities/room.entity';
import { SharedModule } from 'src/shared/shared.module';
import { RoomsResolver } from './rooms.resolver';
import { RoomsService } from './rooms.service';

@Module({
  imports: [TypeOrmModule.forFeature([RoomEntity]), SharedModule],
  providers: [RoomsResolver, RoomsService],
})
export class RoomsModule {}
