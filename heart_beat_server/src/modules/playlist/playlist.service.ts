import { Injectable, NotFoundException } from '@nestjs/common';
import { CreatePlaylistDto } from './dto/create-playlist.dto';
import { Playlist } from 'src/entities/playlist.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from 'src/entities/user.entity';
import { PlaylistResponseDto } from './dto/playlist-response.dto';
import { plainToInstance } from 'class-transformer';
import { EventEmitter2, OnEvent } from '@nestjs/event-emitter';
import { MoodTracking } from 'src/entities/mood-tracking.entity';
import { CohereClientV2 } from 'cohere-ai';

@Injectable()
export class PlaylistService {
  constructor(
    @InjectRepository(Playlist)
    private readonly playlistRepo: Repository<Playlist>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,

    private readonly eventEmitter: EventEmitter2,
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
      take: 5,
      order: {
        created_at: 'DESC',
      },
    });

    return playlists;
  }

  @OnEvent('mood.tracked')
  async handleJournalCreation(mood_tracking: MoodTracking) {
    const cohere = new CohereClientV2({
      token: process.env.CH_API_KEY,
    });

    const response = await cohere.chat({
      model: 'command-a-03-2025',
      messages: [
        {
          role: 'user',
          content: `Generate a name or phrase and color hex (without the #) for a playlist that is based on the following moods: ${mood_tracking.mood}.
          Return ONLY a string with two fields in this format: playlist-name,color. Don't give me an explanation as to why you picked those choices and do not wrap the title in quotations and no space after the comma.
          Your output should look similar to A Chill Day,BC3EC2`,
        },
      ],
      temperature: 0.8,
    });

    const playlistDetails = response.message.content![0]['text'] as string;

    const splitDetails = playlistDetails.split(',');

    const newPlaylist = this.playlistRepo.create({
      name: splitDetails[0],
      color: splitDetails[1],
      is_auto_generated: true,
      user: mood_tracking.user,
    });

    await this.playlistRepo.save(newPlaylist);

    this.eventEmitter.emit('playlist.generated', mood_tracking, newPlaylist);
  }
}
