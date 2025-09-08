import { Injectable } from '@nestjs/common';
import { CreateSongMoodDto } from './dto/create-song-mood.dto';
import { UpdateSongMoodDto } from './dto/update-song-mood.dto';

@Injectable()
export class SongMoodsService {
  create(createSongMoodDto: CreateSongMoodDto) {
    return 'This action adds a new songMood';
  }

  findAll() {
    return `This action returns all songMoods`;
  }

  findOne(id: number) {
    return `This action returns a #${id} songMood`;
  }

  update(id: number, updateSongMoodDto: UpdateSongMoodDto) {
    return `This action updates a #${id} songMood`;
  }

  remove(id: number) {
    return `This action removes a #${id} songMood`;
  }
}
