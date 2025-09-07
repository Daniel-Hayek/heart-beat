import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { PlaylistService } from './playlist.service';
import { CreatePlaylistDto } from './dto/create-playlist.dto';
import { ApiBody, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('Playlist Endpoints')
@Controller('playlist')
export class PlaylistController {
  constructor(private readonly playlistService: PlaylistService) {}

  @ApiOperation({ summary: 'Create a new playlist for a user' })
  @ApiResponse({ status: 201, description: 'New playlist added successfully' })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({
    status: 404,
    description: 'No user with that ID',
  })
  @ApiBody({ type: CreatePlaylistDto })
  @Post()
  create(@Body() createPlaylistDto: CreatePlaylistDto) {
    return this.playlistService.create(createPlaylistDto);
  }

  @Get()
  findAll() {
    return this.playlistService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.playlistService.findOne(+id);
  }

  // @Patch(':id')
  // update(@Param('id') id: string, @Body() updatePlaylistDto: UpdatePlaylistDto) {
  //   return this.playlistService.update(+id, updatePlaylistDto);
  // }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.playlistService.remove(+id);
  // }
}
