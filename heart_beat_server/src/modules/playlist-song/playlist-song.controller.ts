import { Controller, Get, Post, Body, Param, UseGuards } from '@nestjs/common';
import { PlaylistSongService } from './playlist-song.service';
import { CreatePlaylistSongDto } from './dto/create-playlist-song.dto';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@ApiTags('Playlist - Song Relation Endpoints')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
@Controller('playlist-song')
export class PlaylistSongController {
  constructor(private readonly playlistSongService: PlaylistSongService) {}

  @ApiOperation({ summary: 'Add a song to a playlist' })
  @ApiResponse({
    status: 201,
    description: 'Song added to playlist successfully',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({
    status: 404,
    description: 'No playlist OR song with given ID',
  })
  @ApiBody({ type: CreatePlaylistSongDto })
  @Post()
  create(@Body() createPlaylistSongDto: CreatePlaylistSongDto) {
    return this.playlistSongService.create(createPlaylistSongDto);
  }

  @ApiOperation({ summary: 'Fetch a list of songs in a playlist' })
  @ApiResponse({
    status: 200,
    description: 'List of songs',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({
    status: 404,
    description: 'No playlist with given ID',
  })
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
