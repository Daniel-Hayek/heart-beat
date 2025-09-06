import { ApiProperty } from "@nestjs/swagger";
import { IsString } from "class-validator";

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

  
}



  @IsString()
  @Column({ type: 'varchar', nullable: true })
  album: string | null;

  @IsString()
  @Column({ type: 'varchar', nullable: true })
  duration: number | null;

  @IsString()
  @Column()
  song_url: string;