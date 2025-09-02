import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, IsString, MinLength } from 'class-validator';

export class CreateUserDto {
  @ApiProperty({ description: 'Name of the user', example: 'Bob' })
  @IsString()
  name: string;

  @ApiProperty({ description: 'Email of the user', example: 'bob@email.com' })
  @IsEmail()
  email: string;

  @ApiProperty({
    description:
      'Password of the user`s account, will be hashed in the database and must be more than 6 characters',
    example: 'passpass',
  })
  @IsString()
  @MinLength(6)
  password: string;
}
