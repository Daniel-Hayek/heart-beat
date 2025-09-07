import { Injectable, NotFoundException } from '@nestjs/common';
import { CreatePlaylistDto } from './dto/create-playlist.dto';
import { Playlist } from 'src/entities/playlist.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from 'src/entities/user.entity';
import { PlaylistResponseDto } from './dto/playlist-response.dto';
import { plainToInstance } from 'class-transformer';

@Injectable()
export class PlaylistService {
  constructor(
    @InjectRepository(Playlist)
    private readonly playlistRepo: Repository<Playlist>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
  ) {}

  async create(createPlaylistDto: CreatePlaylistDto) {
    const user = await this.userRepo.findOne({
      where: { id: createPlaylistDto.userId },
    });

    if (user == null) {
      throw new NotFoundException('No user with such an ID');
    }

    const playlist = this.playlistRepo.create({
      name: createPlaylistDto.name,
      user,
    });

    const response = this.playlistRepo.save(playlist);

    return plainToInstance(PlaylistResponseDto, response, {
      excludeExtraneousValues: true,
    });
  }

  findAll() {
    return this.playlistRepo.find();
  }

  async findPlaylistsByUserId(userId: number) {
    const user = await this.userRepo.findOne({ where: { id: userId } });

    if (user == null) {
      throw new NotFoundException('No user with that ID');
    }

    const playlists = await this.playlistRepo.find({
      where: { user: { id: userId } },
    });

    return playlists;
  }
}
