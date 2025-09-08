import { Injectable, NotFoundException } from '@nestjs/common';
import { AssignMoodDto } from './dto/assign-mood.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Song } from 'src/entities/song.entity';
import { Mood } from 'src/entities/moods.entity';
import { Repository } from 'typeorm';

@Injectable()
export class SongMoodsService {
  constructor(
    @InjectRepository(Song)
    private readonly songRepo: Repository<Song>,
    @InjectRepository(Mood)
    private readonly moodRepo: Repository<Mood>,
  ) {}

  async assignMoodToSong(assignMoodDto: AssignMoodDto) {
    const song = await this.songRepo.findOne({
      where: { id: assignMoodDto.songId },
      relations: ['moods'],
    });

    if (song == null) {
      throw new NotFoundException('No song with that ID');
    }

    const mood = await this.moodRepo.findOne({
      where: { id: assignMoodDto.moodId },
    });

    if (mood == null) {
      throw new NotFoundException('No mood with that ID');
    }

    song.moods = [...song.moods, mood];

    return this.songRepo.save(song);
  }
}
