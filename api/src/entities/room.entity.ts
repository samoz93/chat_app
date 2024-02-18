import {
  Column,
  Entity,
  ManyToMany,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { BaseEntity } from './base.entity';
import { MessageEntity } from './message.entity';
import { UserEntity } from './user.entity';

@Entity('room')
export class RoomEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;
  @Column()
  name: string;
  @Column()
  description: string;

  @ManyToOne(() => UserEntity, (user) => user.ownedRooms)
  owner: UserEntity;

  @ManyToMany(() => UserEntity, (user) => user.rooms)
  users: UserEntity[];

  @OneToMany(() => MessageEntity, (message) => message.room, {
    cascade: true,
  })
  messages: MessageEntity[];

  @Column({ default: true })
  isPublic: boolean;
}
