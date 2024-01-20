import { Controller, Post, Request } from '@nestjs/common';

@Controller('auth')
export class AuthController {
  @Post('login')
  async login(@Request() req: Request & { user: any }) {
    console.log('AuthController.login', req.user);
    return req.user;
  }
}
