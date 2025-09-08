import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class CreateMoodDto {
  @ApiProperty({
    description: 'Name of the mood label',
    example: 'Happy',
  })
  @IsString()
  title: string;
}
