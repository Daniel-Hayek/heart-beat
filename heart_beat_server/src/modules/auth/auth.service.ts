import {
  BadRequestException,
  Injectable,
  UnauthorizedException,
} from '@nestjs/common';
import { UsersService } from '../users/users.service';
import { User } from 'src/entities/user.entity';
import { JwtService } from '@nestjs/jwt';
import { CreateUserDto } from '../users/dto/create-user.dto';
import * as bcrypt from 'bcrypt';

@Injectable()
export class AuthService {
  constructor(
    private readonly usersService: UsersService,
    private readonly jwtService: JwtService,
  ) {}

  async validateUser(email: string, password: string): Promise<User> {
    const user = await this.usersService.findOneByEmail(email);

    if (user) {
      const validPass = await bcrypt.compare(password, user.password);
      if (validPass) {
        console.log(email, password);
        return user;
      }
    }

    throw new UnauthorizedException(`Test`);
  }

  async register(dto: CreateUserDto): Promise<User> {
    const exists = await this.usersService.findOneByEmail(dto.email);

    if (exists) {
      throw new BadRequestException('Email already used');
    }

    const user = await this.usersService.create(dto);

    return user;
  }

  login(user: Omit<User, 'password'>) {
    const payload = { sub: user.id, email: user.email };
    console.log('jwt', process.env.JWT_SECRET);
    return { accessToken: this.jwtService.sign(payload) };
  }

  logout(userId: number) {
    return `User ${userId} logged out successfully`;
  }
}
