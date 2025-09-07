import { ApiProperty } from '@nestjs/swagger';
import { IsInt } from 'class-validator';

export class CreatePlaylistSongDto {
  @ApiProperty({
    description: 'The ID of the playlist',
    example: 6,
  })
  @IsInt()
  playlistId: number;

  @ApiProperty({
    description: 'The ID of the song',
    example: 43,
  })
  @IsInt()
  songId: number;
}
