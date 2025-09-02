import { Exclude } from 'class-transformer';

export class ResponseUserDto {
  @Exclude()
  id: number;

  name: string;

  email: string;

  @Exclude()
  password: string;

  created_at: Date;

  updated_at: Date;
}
