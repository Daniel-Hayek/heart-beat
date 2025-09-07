import { ApiProperty } from '@nestjs/swagger';
import { IsBoolean, IsInt, IsOptional, IsString } from 'class-validator';

export class CreatePlaylistDto {
  @ApiProperty({
    description: 'The ID of the user who this playlist belongs to',
    example: 21,
  })
  @IsInt()
  userId: number;

  @ApiProperty({
    description:
      'The title of the playlist, usually a descriptor of what it contains',
    example: 'A Chill Day',
  })
  @IsString()
  name: string;

  @ApiProperty({
    description:
      'A flag of whether the playlist was created by the user or through AI',
    default: false,
  })
  @IsBoolean()
  @IsOptional()
  is_auto_generated: boolean;
}
