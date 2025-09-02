import {
  Body,
  Controller,
  Get,
  Post,
  Request,
  UseGuards,
} from '@nestjs/common';
import { AuthService } from './auth.service';
import {
  ApiBearerAuth,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { LoginUserDto } from './dto/login-user.dto';
import { JwtAuthGuard } from './jwt-auth.guard';
import { CreateUserDto } from '../users/dto/create-user.dto';

@ApiTags('Authentication')
@Controller('auth')
export class AuthController {
  constructor(private readonly authService: AuthService) {}

  @ApiOperation({
    summary: 'Register a new user in the database and return their token',
  })
  @ApiResponse({ status: 201, description: 'User successfully registered' })
  @ApiResponse({
    status: 409,
    description: 'User with that email already exists',
  })
  @Post('register')
  async register(@Body() createUserDto: CreateUserDto) {
    const user = await this.authService.register(createUserDto);
    user.password = createUserDto.password;

    return this.login(user);
  }

  @ApiOperation({
    summary: 'Login a user and return their token',
  })
  @ApiResponse({ status: 201, description: 'User successfully logged in' })
  @ApiResponse({
    status: 400,
    description: 'Invalid email format OR short password',
  })
  @ApiResponse({
    status: 401,
    description: 'Invalid Credentials',
  })
  @Post('login')
  async login(@Body() loginUserDto: LoginUserDto) {
    const user = await this.authService.validateUser(
      loginUserDto.email,
      loginUserDto.password,
    );

    return this.authService.login(user);
  }

  @ApiBearerAuth()
  @UseGuards(JwtAuthGuard)
  @ApiOperation({ summary: 'Test API to check JWT Funcationality' })
  @ApiResponse({ status: 200, description: 'JWT Token successfully accepted' })
  @ApiResponse({ status: 401, description: 'Unauthorized, token not provided' })
  @Get('test')
  test(@Request() req) {
    console.log(req);
    return 'Hello World';
  }
}
