import * as _ from 'lodash';
import { UserEntity } from 'src/entities/user.entity';

export const sanitizeUser = (user: UserEntity) => {
  return _.omit(user, ['password']);
};
