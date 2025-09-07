import { Test, TestingModule } from '@nestjs/testing';
import { PlaylistSongController } from './playlist-song.controller';
import { PlaylistSongService } from './playlist-song.service';
import { CreatePlaylistSongDto } from './dto/create-playlist-song.dto';
import { NotFoundException } from '@nestjs/common';

describe('PlaylistSongController', () => {
  let controller: PlaylistSongController;

  const mockPlaylistSongService = {
    create: jest.fn(),
    getSongsInPlaylist: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PlaylistSongController],
      providers: [
        { provide: PlaylistSongService, useValue: mockPlaylistSongService },
      ],
    }).compile();

    controller = module.get<PlaylistSongController>(PlaylistSongController);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  describe('create', () => {
    it('should call service.create and return the result', async () => {
      const dto: CreatePlaylistSongDto = { playlistId: 1, songId: 2 };
      const mockResult = { id: 123, playlistId: 1, songId: 2 };
      mockPlaylistSongService.create.mockResolvedValue(mockResult);

      const result = await controller.create(dto);

      expect(mockPlaylistSongService.create).toHaveBeenCalledWith(dto);
      expect(result).toEqual(mockResult);
    });

    it('should propagate NotFoundException from service', async () => {
      const dto: CreatePlaylistSongDto = { playlistId: 1, songId: 2 };
      mockPlaylistSongService.create.mockRejectedValue(new NotFoundException());

      await expect(controller.create(dto)).rejects.toThrow(NotFoundException);
    });
  });

  describe('getSongsInPlaylist', () => {
    it('should call service.getSongsInPlaylist with playlistId', async () => {
      const playlistId = '1';
      const mockSongs = [{ id: 1 }, { id: 2 }];
      mockPlaylistSongService.getSongsInPlaylist.mockResolvedValue(mockSongs);

      const result = await controller.getSongsInPlaylist(playlistId);

      expect(mockPlaylistSongService.getSongsInPlaylist).toHaveBeenCalledWith(
        1,
      );
      expect(result).toEqual(mockSongs);
    });

    it('should propagate NotFoundException from service', async () => {
      const playlistId = '1';
      mockPlaylistSongService.getSongsInPlaylist.mockRejectedValue(
        new NotFoundException(),
      );

      await expect(controller.getSongsInPlaylist(playlistId)).rejects.toThrow(
        NotFoundException,
      );
    });
  });
});
