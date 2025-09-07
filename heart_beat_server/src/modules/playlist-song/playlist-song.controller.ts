import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { PlaylistSongService } from './playlist-song.service';
import { CreatePlaylistSongDto } from './dto/create-playlist-song.dto';
import { ApiTags } from '@nestjs/swagger';

@ApiTags('Playlist - Song Relation Endpoints')
@Controller('playlist-song')
export class PlaylistSongController {
  constructor(private readonly playlistSongService: PlaylistSongService) {}

  @Post()
  create(@Body() createPlaylistSongDto: CreatePlaylistSongDto) {
    return this.playlistSongService.create(createPlaylistSongDto);
  }

  @Get(':id')
  getSongsInPlaylist(@Param('id') playlistId: string) {
    return this.playlistSongService.getSongsInPlaylist(+playlistId);
  }

  // @Get()
  // findAll() {
  //   return this.playlistSongService.findAll();
  // }

  // @Patch(':id')
  // update(@Param('id') id: string, @Body() updatePlaylistSongDto: UpdatePlaylistSongDto) {
  //   return this.playlistSongService.update(+id, updatePlaylistSongDto);
  // }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.playlistSongService.remove(+id);
  // }
}
