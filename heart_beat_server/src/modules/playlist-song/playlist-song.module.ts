import { Module } from '@nestjs/common';
import { PlaylistSongService } from './playlist-song.service';
import { PlaylistSongController } from './playlist-song.controller';

@Module({
  controllers: [PlaylistSongController],
  providers: [PlaylistSongService],
})
export class PlaylistSongModule {}
