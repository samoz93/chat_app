import {
  Column,
  Entity,
  JoinTable,
  ManyToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { BaseEntity } from './base.entity';
import { RoomEntity } from './room.entity';

@Entity('user')
export class UserEntity extends BaseEntity {
  @PrimaryGeneratedColumn('uuid')
  id: string;
  @Column()
  name: string;
  @Column()
  email: string;
  @Column()
  password: string;

  @ManyToMany(() => RoomEntity, (room) => room, {
    cascade: true,
  })
  @JoinTable()
  rooms?: RoomEntity[];

  @ManyToMany(() => UserEntity, (user) => user)
  @JoinTable()
  friends?: UserEntity[];
}
