import { HttpException } from '@nestjs/common';
import { CONFIG } from 'src/config';

export abstract class CustomError extends HttpException {
  abstract type: string;
  constructor(
    message: string,
    private code: number,
    error: any,
  ) {
    super(message, code, { cause: error });
  }

  get responseErrorCode() {
    return this.code;
  }

  get responseErrorMessage() {
    return this.message;
  }

  get responseErrorCause() {
    return this.cause;
  }

  get fieldErrors() {
    return null;
  }

  get errorPayload() {
    return null;
  }

  get formattedError(): {
    message: string;
    code: number;
    fields?: any;
    cause?: any;
    type: string;
    payload?: any;
  } {
    return {
      message: this.responseErrorMessage,
      code: this.responseErrorCode,
      fields: this.fieldErrors,
      payload: this.errorPayload,
      cause: CONFIG.isDev ? this.responseErrorCause : null,
      type: this.type,
    };
  }
}
