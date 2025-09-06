import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsString } from 'class-validator';

export class CreateSongDto {
  @ApiProperty({
    description: 'Title of the song',
    example: 'Vibing Over Venus',
  })
  @IsString()
  title: string;

  @ApiProperty({
    description: 'Artist of the song',
    example: 'Kevin MacLeod',
  })
  @IsString()
  artist: string;

  @ApiProperty({ description: 'Duration of the song in seconds', example: 411 })
  @IsInt()
  duration: number | null;

  @ApiProperty({
    description: 'Supabase path of the song',
    example: 'Vibing%20Over%20Venus.mp3',
  })
  @IsString()
  song_url: string;
}
