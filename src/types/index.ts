import { UserEntity } from 'src/entities/user.entity';

export type MyRequest = Request & { user: UserEntity };
