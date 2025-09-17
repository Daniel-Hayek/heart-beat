import { ApiProperty } from '@nestjs/swagger';
import { IsInt } from 'class-validator';

export class RemoveMoodDto {
  @ApiProperty({
    description: 'ID of the song',
    example: 43,
  })
  @IsInt()
  songId: number;

  @ApiProperty({
    description: 'ID of the mood',
    example: 1,
  })
  @IsInt()
  moodId: number;
}
