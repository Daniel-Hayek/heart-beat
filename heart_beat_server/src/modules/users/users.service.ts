import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';
import * as bcrypt from 'bcrypt';
@Injectable()
export class UsersService {
  private readonly salt = 10;

  constructor(
    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
  ) {}

  async create(createUserDto: CreateUserDto): Promise<User> {
    const check = await this.findOneByEmail(createUserDto.email);

    if (check != null) {
      throw new ConflictException('A user with email already exists');
    }

    const hashed = await bcrypt.hash(createUserDto.password, this.salt);

    const user = this.userRepo.create({
      name: createUserDto.name,
      email: createUserDto.email,
      password: hashed,
    });

    return this.userRepo.save(user);
  }

  async findAll() {
    const users = await this.userRepo.find();
    return users;
  }

  findOne(id: number) {
    return `This action returns a #${id} user`;
  }

  async findOneByEmail(email: string): Promise<User | null> {
    const user = await this.userRepo.findOne({ where: { email } });

    if (!user) {
      return null;
    }

    return user;
  }

  async update(id: number, updateUserDto: UpdateUserDto): Promise<User> {
    const user = await this.userRepo.findOne({ where: { id } });

    if (!user) {
      throw new NotFoundException(`User with id ${id} not found`);
    }

    Object.assign(user, updateUserDto);

    return this.userRepo.save(user);
  }

  async remove(id: number): Promise<string> {
    if (!(await this.userRepo.findOne({ where: { id } }))) {
      throw new NotFoundException(`User with id ${id} not found`);
    }

    await this.userRepo.delete(id);
    return `User ${id} deleted`;
  }
}
