import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';
@Injectable()
export class UsersService {
  constructor(
    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
  ) {}

  create(createUserDto: CreateUserDto): Promise<User> {
    const user = this.userRepo.create({
      name: createUserDto.name,
      email: createUserDto.email,
      password: createUserDto.password,
    });

    return this.userRepo.save(user);
  }

  findAll() {
    return `This action returns all users`;
  }

  findOne(id: number) {
    return `This action returns a #${id} user`;
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
