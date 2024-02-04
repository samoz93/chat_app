import { createMock } from '@golevelup/ts-jest';
import { ExecutionContext } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { MockUsers } from 'src/test_utils/constants';
import { TokenService } from 'src/utils';
import { GQAuthGuard } from './auth.guard';

describe('AuthGuard', () => {
  let auth: GQAuthGuard;

  describe('RolesGuard', () => {
    let guard: GQAuthGuard;
    let reflector: Reflector;
    let tokenService: TokenService;
    beforeEach(async () => {
      reflector = new Reflector();
      tokenService = jest.mock('TokenService', () => {
        return {
          validateToken: jest.fn().mockReturnValue(MockUsers[0]),
        };
      }) as unknown as TokenService;
      guard = new GQAuthGuard(reflector, tokenService);
    });

    it('should be defined', () => {
      expect(guard).toBeDefined();
    });

    it('should return true if it is a public route', () => {
      reflector.getAllAndOverride = jest.fn().mockReturnValue(true);
      const context = createMock<ExecutionContext>();
      const canActivate = guard.canActivate(context);
      expect(canActivate).toBe(true);
    });

    it('should return false if it is not public and no jwt token is provided', () => {
      reflector.getAllAndOverride = jest.fn().mockReturnValue(false);
      const context = createMock<ExecutionContext>();
      const canActivate = guard.canActivate(context);
      expect(canActivate).toBe(true);
    });
  });
});
