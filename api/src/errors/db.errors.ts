import { CustomError } from './base.error';

export class DatabaseError extends CustomError {
  type: string = 'DatabaseError';
  constructor(
    error: any,
    private payload: any,
  ) {
    super('Database error', 500, error);
  }

  get errorPayload() {
    return this.payload;
  }
}

export class InternalError extends CustomError {
  type: string = 'UnknownError';
  constructor(error: any) {
    super('Internal server error', 500, error);
  }
}
