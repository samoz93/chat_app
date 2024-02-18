import { to as main_to } from 'await-to-js';
import { CustomError } from 'src/errors/base.error';

function to<T, Error extends CustomError = CustomError>(
  promise: Promise<T>,
  errorExt?: object,
) {
  return main_to<T, Error>(promise, errorExt);
}

export { to };
