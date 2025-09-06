import { Injectable } from '@nestjs/common';
import { CreateSongDto } from './dto/create-song.dto';
import { Song } from 'src/entities/song.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class SongsService {
  constructor(
    @InjectRepository(Song)
    private readonly songRepo: Repository<Song>,
  ) {}

  create(createSongDto: CreateSongDto) {
    const song = this.songRepo.create({
      title: createSongDto.title,
      artist: createSongDto.artist,
      duration: createSongDto.duration,
      song_url: createSongDto.song_url,
    });

    return this.songRepo.save(song);
  }

  findAll() {
    return `This action returns all songs`;
  }

  findOne(id: number) {
    return `This action returns a #${id} song`;
  }

  remove(id: number) {
    return `This action removes a #${id} song`;
  }
}
