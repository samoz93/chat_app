import {
  Column,
  Entity,
  JoinTable,
  ManyToMany,
  OneToMany,
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

  @ManyToMany(() => RoomEntity, (room) => room.users)
  @JoinTable()
  rooms?: RoomEntity[];

  @OneToMany(() => RoomEntity, (room) => room.owner)
  ownedRooms: RoomEntity[];

  @ManyToMany(() => UserEntity, (user) => user)
  friends?: UserEntity[];
}
