import { Test, TestingModule } from '@nestjs/testing';
import { PlaylistSongService } from './playlist-song.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Playlist } from 'src/entities/playlist.entity';
import { Song } from 'src/entities/song.entity';
import { PlaylistSong } from 'src/entities/playlist-song.entity';
import { NotFoundException } from '@nestjs/common';
import { Repository } from 'typeorm';

describe('PlaylistSongService', () => {
  let service: PlaylistSongService;
  let playlistRepo: Repository<Playlist>;
  let songRepo: Repository<Song>;
  let playlistSongRepo: Repository<PlaylistSong>;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        PlaylistSongService,
        { provide: getRepositoryToken(Playlist), useClass: Repository },
        { provide: getRepositoryToken(Song), useClass: Repository },
        { provide: getRepositoryToken(PlaylistSong), useClass: Repository },
      ],
    }).compile();

    service = module.get<PlaylistSongService>(PlaylistSongService);
    playlistRepo = module.get(getRepositoryToken(Playlist));
    songRepo = module.get(getRepositoryToken(Song));
    playlistSongRepo = module.get(getRepositoryToken(PlaylistSong));
  });

  describe('create', () => {
    it('should throw if playlist not found', async () => {
      jest.spyOn(playlistRepo, 'findOne').mockResolvedValue(null);

      await expect(
        service.create({ playlistId: 1, songId: 1 }),
      ).rejects.toThrow(NotFoundException);
    });

    it('should throw if song not found', async () => {
      jest
        .spyOn(playlistRepo, 'findOne')
        .mockResolvedValue({ id: 1 } as Playlist);
      jest.spyOn(songRepo, 'findOne').mockResolvedValue(null);

      await expect(
        service.create({ playlistId: 1, songId: 1 }),
      ).rejects.toThrow(NotFoundException);
    });

    it('should create and save a playlistSong', async () => {
      const mockPlaylist = { id: 1 } as Playlist;
      const mockSong = { id: 2 } as Song;
      const mockPlaylistSong = {
        id: 123,
        playlist: mockPlaylist,
        song: mockSong,
        orderIndex: 1,
      } as PlaylistSong;

      jest.spyOn(playlistRepo, 'findOne').mockResolvedValue(mockPlaylist);
      jest.spyOn(songRepo, 'findOne').mockResolvedValue(mockSong);
      jest.spyOn(playlistSongRepo, 'count').mockResolvedValue(0);
      jest.spyOn(playlistSongRepo, 'create').mockReturnValue(mockPlaylistSong);
      jest.spyOn(playlistSongRepo, 'save').mockResolvedValue(mockPlaylistSong);

      const result = await service.create({ playlistId: 1, songId: 2 });
      expect(result).toEqual(mockPlaylistSong);
      expect(jest.spyOn(playlistSongRepo, 'save')).toHaveBeenCalledWith(
        mockPlaylistSong,
      );
    });
  });

  describe('getSongsInPlaylist', () => {
    it('should return songs from playlistSongs', async () => {
      const mockSongs = [{ id: 1 }, { id: 2 }] as Song[];
      const mockPlaylistSongs = mockSongs.map((song, i) => ({
        id: i + 1,
        song,
        orderIndex: i,
      })) as PlaylistSong[];

      jest.spyOn(playlistSongRepo, 'find').mockResolvedValue(mockPlaylistSongs);

      const result = await service.getSongsInPlaylist(1);
      expect(result).toEqual(mockSongs);
    });
  });
});
