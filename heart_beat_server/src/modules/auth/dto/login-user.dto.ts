import { ApiProperty } from '@nestjs/swagger';
import { IsEmail, MinLength } from 'class-validator';

export class LoginUserDto {
  @ApiProperty({
    description: 'Email of the user`s account',
    example: 'daniel@mail.com',
  })
  @IsEmail()
  email: string;

  @ApiProperty({
    description: 'Password of the related account',
    example: 'passpass',
  })
  @MinLength(6)
  password: string;
}
