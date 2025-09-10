import { Injectable, NotFoundException } from '@nestjs/common';
import { CreatePlaylistSongDto } from './dto/create-playlist-song.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { Playlist } from 'src/entities/playlist.entity';
import { Repository } from 'typeorm';
import { Song } from 'src/entities/song.entity';
import { PlaylistSong } from 'src/entities/playlist-song.entity';
import { MoodTracking } from 'src/entities/mood-tracking.entity';

@Injectable()
export class PlaylistSongService {
  constructor(
    @InjectRepository(Playlist)
    private readonly playlistRepo: Repository<Playlist>,

    @InjectRepository(Song)
    private readonly songRepo: Repository<Song>,

    @InjectRepository(PlaylistSong)
    private readonly playlistSongRepo: Repository<PlaylistSong>,
  ) {}

  async create(createPlaylistSongDto: CreatePlaylistSongDto) {
    const playlist = await this.playlistRepo.findOne({
      where: { id: createPlaylistSongDto.playlistId },
    });

    if (playlist == null) {
      throw new NotFoundException('No such playlist ID');
    }

    const song = await this.songRepo.findOne({
      where: { id: createPlaylistSongDto.songId },
    });

    if (song == null) {
      throw new NotFoundException('No such song ID');
    }

    const defaultOrder = await this.playlistSongRepo.count({
      where: { playlist: { id: playlist.id } },
    });

    const playlistSong = this.playlistSongRepo.create({
      playlist,
      song,
      orderIndex: defaultOrder + 1,
    });

    return this.playlistSongRepo.save(playlistSong);
  }

  async getSongsInPlaylist(playlistId: number) {
    const playlistSongs = await this.playlistSongRepo.find({
      where: { playlist: { id: playlistId } },
      relations: ['song'],
      order: { orderIndex: 'ASC' },
    });

    if (playlistSongs == null) {
      throw new NotFoundException('No such playlist ID');
    }

    const songs = playlistSongs.map((playlistSong) => playlistSong.song);

    return songs;
  }

  async addMoodSongs(mood_tracking: MoodTracking, playlist: Playlist) {
    const moods = mood_tracking.mood.split(',').map((m) => m.trim());

    const primarySongs = this.songRepo.find({
      where: { moods: { name: moods[0] } },
      take: 3,
    });

    const secondarySongs = this.songRepo.find({
      where: { moods: { name: moods[0] } },
      take: 2,
    });

    const tertiarySongs = this.songRepo.find({
      where: { moods: { name: moods[0] } },
      take: 1,
    });
  }
}
