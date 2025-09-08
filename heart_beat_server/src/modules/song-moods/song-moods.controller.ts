import { Controller, Get, Post, Param, Delete, Body } from '@nestjs/common';
import { SongMoodsService } from './song-moods.service';
import { ApiBody, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AssignMoodDto } from './dto/assign-mood.dto';
import { RemoveMoodDto } from './dto/remove-mood.dto';

@Controller('song-moods')
export class SongMoodsController {
  constructor(private readonly songMoodsService: SongMoodsService) {}

  @ApiOperation({ summary: 'Assign a mood to a song' })
  @ApiResponse({
    status: 201,
    description: 'Mood assigned to song successfully',
  })
  @ApiResponse({ status: 404, description: 'Song OR Mood not found' })
  @ApiBody({ type: AssignMoodDto })
  @Post('assign')
  assignMoodToSong(@Body() assignMoodDto: AssignMoodDto) {
    return this.songMoodsService.assignMoodToSong(assignMoodDto);
  }

  @ApiOperation({ summary: 'Remove a mood from a song' })
  @ApiResponse({ status: 200, description: 'Mood removed from song' })
  @ApiBody({ type: RemoveMoodDto })
  @Delete('remove')
  removeMoodFromSong(@Body() removeMoodDto: RemoveMoodDto) {
    return this.songMoodsService.removeMoodFromSong(removeMoodDto);
  }

  @ApiOperation({ summary: 'Get all moods assigned to a song' })
  @ApiResponse({ status: 200, description: 'List of moods for the song' })
  @Get('/moods/:id')
  getMoodsForSong(@Param('id') id: string) {
    return this.songMoodsService.getMoodsForSong(+id);
  }

  @ApiOperation({ summary: 'Get all songs that have a specific mood' })
  @ApiResponse({ status: 200, description: 'List of songs with that mood' })
  @Get('/songs/:id')
  getSongsForMood(@Param('id') id: string) {
    return this.songMoodsService.getSongsForMood(+id);
  }
}
