import { Module } from '@nestjs/common';
import { PlaylistSongService } from './playlist-song.service';
import { PlaylistSongController } from './playlist-song.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Playlist } from 'src/entities/playlist.entity';
import { Song } from 'src/entities/song.entity';
import { PlaylistSong } from 'src/entities/playlist-song.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Playlist, Song, PlaylistSong])],
  controllers: [PlaylistSongController],
  providers: [PlaylistSongService],
})
export class PlaylistSongModule {}
