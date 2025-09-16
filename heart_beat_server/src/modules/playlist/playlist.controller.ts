import { Controller, Get, Post, Body, UseGuards, Query } from '@nestjs/common';
import { PlaylistService } from './playlist.service';
import { CreatePlaylistDto } from './dto/create-playlist.dto';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiQuery,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@ApiTags('Playlist Endpoints')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
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

  @ApiOperation({
    summary: 'Return a list of all playlists without their users',
  })
  @ApiResponse({
    status: 200,
    description: 'List of playlists',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @Get()
  findAll() {
    return this.playlistService.findAll();
  }

  @ApiOperation({
    summary: 'Return all playlists by a user`s ID',
  })
  @ApiResponse({
    status: 200,
    description: 'List of playlists belonging to one user',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({ status: 404, description: 'No user with that ID' })
  @ApiQuery({ name: 'id', required: true, type: Number, example: 1 })
  @ApiQuery({ name: 'page', required: true, type: Number, example: 1 })
  @Get('/user-playlists/')
  findOneByUser(@Query('id') id, @Query('page') page) {
    return this.playlistService.findPlaylistsByUserId(+id, +page);
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
