import { ArgumentsHost, Catch, HttpException } from '@nestjs/common';
import { GqlExceptionFilter } from '@nestjs/graphql';
import { CustomError } from 'src/errors/base.error';

@Catch(HttpException)
export class HttpExceptionFilter implements GqlExceptionFilter {
  catch(exception: CustomError, host: ArgumentsHost) {
    console.error(exception);
    return exception.formattedError;
  }
}
