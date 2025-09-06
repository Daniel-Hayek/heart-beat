import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { SongsService } from './songs.service';
import { CreateSongDto } from './dto/create-song.dto';
import { ApiBody, ApiOperation, ApiResponse } from '@nestjs/swagger';

@Controller('songs')
export class SongsController {
  constructor(private readonly songsService: SongsService) {}

  @ApiOperation({ summary: 'Add a new song to the database' })
  @ApiResponse({ status: 201, description: 'New song added successfully' })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiBody({ type: CreateSongDto })
  @Post()
  create(@Body() createSongDto: CreateSongDto) {
    return this.songsService.create(createSongDto);
  }

  @ApiOperation({ summary: 'Fetch all songs' })
  @ApiResponse({ status: 200, description: 'Retrieved all songs' })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @Get()
  findAll() {
    return this.songsService.findAll();
  }

  @ApiOperation({ summary: 'Fetch a song`s metadata' })
  @ApiResponse({ status: 200, description: 'Metadata retrieved' })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({
    status: 404,
    description: 'No song with such an ID',
  })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.songsService.findOne(+id);
  }

  // @Delete(':id')
  // remove(@Param('id') id: string) {
  //   return this.songsService.remove(+id);
  // }
}
