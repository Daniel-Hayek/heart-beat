import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { UsersService } from './users.service';
import { CreateUserDto } from './dto/create-user.dto';
import { UpdateUserDto } from './dto/update-user.dto';
import { ApiBody, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('User Endpoints')
@Controller('users')
export class UsersController {
  constructor(private readonly usersService: UsersService) {}

  @Post()
  @ApiOperation({ summary: 'Create a new user' })
  @ApiResponse({ status: 201, description: 'New user created successfully' })
  @ApiResponse({
    status: 409,
    description: 'A user with email already exists',
  })
  @ApiBody({ type: CreateUserDto })
  create(@Body() createUserDto: CreateUserDto) {
    return this.usersService.create(createUserDto);
  }

  @Get()
  @ApiOperation({ summary: 'Get all users' })
  @ApiResponse({ status: 200, description: 'List of all users' })
  findAll() {
    return this.usersService.findAll();
  }

  @ApiOperation({ summary: 'Get a specific user by their ID' })
  @ApiResponse({ status: 200, description: 'Details of user with given ID' })
  @ApiResponse({ status: 404, description: 'No user with such an ID found' })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.usersService.findOne(+id);
  }

  @ApiOperation({ summary: 'Update a specific user by their ID' })
  @ApiResponse({
    status: 200,
    description: 'Details of updated user with given ID',
  })
  @ApiResponse({ status: 404, description: 'No user with such an ID found' })
  @ApiResponse({ status: 409, description: 'A user with email already exists' })
  @Patch(':id')
  update(@Param('id') id: string, @Body() updateUserDto: UpdateUserDto) {
    return this.usersService.update(+id, updateUserDto);
  }

  @ApiOperation({ summary: 'Delete a specific user by their ID' })
  @ApiResponse({
    status: 200,
    description: 'User has been successfully deleted',
  })
  @ApiResponse({ status: 404, description: 'No user with such an ID found' })
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.usersService.remove(+id);
  }
}
