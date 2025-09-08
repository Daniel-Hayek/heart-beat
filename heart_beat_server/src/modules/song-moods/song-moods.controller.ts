import { Controller, Get, Post, Param, Delete, Body } from '@nestjs/common';
import { SongMoodsService } from './song-moods.service';
import { ApiBody, ApiOperation, ApiResponse } from '@nestjs/swagger';
import { AssignMoodDto } from './dto/assign-mood.dto';

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

  // // Remove a mood from a song
  // @Delete(':songId/moods/:moodId')
  // removeMoodFromSong(
  //   @Param('songId', ParseIntPipe) songId: number,
  //   @Param('moodId', ParseIntPipe) moodId: number,
  // ) {
  //   return this.songMoodsService.removeMoodFromSong(songId, moodId);
  // }

  // // Get all moods for a song
  // @Get(':songId/moods')
  // getMoodsForSong(@Param('songId', ParseIntPipe) songId: number) {
  //   return this.songMoodsService.getMoodsForSong(songId);
  // }

  // // Get all songs for a mood
  // @Get('mood/:moodId/songs')
  // getSongsForMood(@Param('moodId', ParseIntPipe) moodId: number) {
  //   return this.songMoodsService.getSongsForMood(moodId);
  // }
}
