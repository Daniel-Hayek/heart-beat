import { Body, Controller, Post, Req, UseGuards } from '@nestjs/common';
import { AuthService } from './auth.service';
import { AuthGuard } from '@nestjs/passport';

@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @Post('register')
  async register(
    @Body() body: { name: string; email: string; password: string },
  ) {
    const user = await this.authService.register(body);
    user.password = body.password;

    return this.login(user);
  }

  @Post('login')
  async login(@Body() body: { email: string; password: string }) {
    const user = await this.authService.validateUser(body.email, body.password);
    // return user;
    return this.authService.login(user);
  }

  @UseGuards(AuthGuard('jwt'))
  @Post('logout')
  logout(@Req() id: number) {
    return this.authService.logout(id);
  }
}
