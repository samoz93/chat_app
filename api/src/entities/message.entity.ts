import {
  Column,
  Entity,
  ManyToOne,
  OneToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { BaseEntity } from './base.entity';
import { RoomEntity } from './room.entity';
import { UserEntity } from './user.entity';

@Entity('message')
export class MessageEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;
  @Column()
  text: string;
  @OneToOne(() => UserEntity, {
    onDelete: 'CASCADE',
  })
  user: UserEntity;
  @ManyToOne(() => RoomEntity, (message) => message)
  room: RoomEntity;
}
