import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { SongMoodsService } from './song-moods.service';
import { CreateSongMoodDto } from './dto/create-song-mood.dto';
import { UpdateSongMoodDto } from './dto/update-song-mood.dto';

@Controller('song-moods')
export class SongMoodsController {
  constructor(private readonly songMoodsService: SongMoodsService) {}

  @Post()
  create(@Body() createSongMoodDto: CreateSongMoodDto) {
    return this.songMoodsService.create(createSongMoodDto);
  }

  @Get()
  findAll() {
    return this.songMoodsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.songMoodsService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateSongMoodDto: UpdateSongMoodDto) {
    return this.songMoodsService.update(+id, updateSongMoodDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.songMoodsService.remove(+id);
  }
}
