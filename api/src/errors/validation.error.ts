import { CustomError } from './base.error';

type IFieldError = { field: string; message: string };

export class ExternalValidationError extends CustomError {
  type = 'ValidationError';

  constructor(private fields: Record<string, string>) {
    super('Input validation error', 406, null);
  }

  override get fieldErrors() {
    const errors: IFieldError[] = [];
    for (const key in this.fields) {
      errors[key] = this.fields[key].replace(/"/g, '');
    }
    return errors;
  }
}

export class NotFoundError extends CustomError {
  type = 'NotFound';
  constructor(private payload: any) {
    super('Resources not found', 404, null);
  }

  override get errorPayload() {
    return this.payload;
  }
}

export class CustomUnauthorizedException extends CustomError {
  type = 'Unauthorized';

  constructor(cause: string | Error) {
    super(
      'Unauthorized for this action',
      401,
      cause instanceof Error ? cause : new Error(cause),
    );
  }
}
