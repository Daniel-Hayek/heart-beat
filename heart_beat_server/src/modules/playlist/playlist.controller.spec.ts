import { Test, TestingModule } from '@nestjs/testing';
import { PlaylistController } from './playlist.controller';
import { PlaylistService } from './playlist.service';
import { CreatePlaylistDto } from './dto/create-playlist.dto';
import { NotFoundException } from '@nestjs/common';

describe('PlaylistController', () => {
  let controller: PlaylistController;
  let service: Partial<PlaylistService>;

  beforeEach(async () => {
    service = {
      create: jest.fn(),
      findAll: jest.fn(),
      findPlaylistsByUserId: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [PlaylistController],
      providers: [{ provide: PlaylistService, useValue: service }],
    }).compile();

    controller = module.get<PlaylistController>(PlaylistController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('create', () => {
    it('should call service.create and return a playlist', async () => {
      const dto: CreatePlaylistDto = {
        name: 'My Playlist',
        userId: 1,
        is_auto_generated: false,
      };
      const mockPlaylist = { id: 1, name: dto.name };

      (service.create as jest.Mock).mockResolvedValue(mockPlaylist);

      const result = await controller.create(dto);

      expect(service.create).toHaveBeenCalledWith(dto);
      expect(result).toEqual(mockPlaylist);
    });

    it('should throw NotFoundException if user not found', async () => {
      const dto: CreatePlaylistDto = {
        name: 'My Playlist',
        userId: 1,
        is_auto_generated: false,
      };

      (service.create as jest.Mock).mockRejectedValue(new NotFoundException());

      await expect(controller.create(dto)).rejects.toThrow(NotFoundException);
    });
  });

  describe('findAll', () => {
    it('should call service.findAll and return all playlists', async () => {
      const mockPlaylists = [{ id: 1 }, { id: 2 }];
      (service.findAll as jest.Mock).mockResolvedValue(mockPlaylists);

      const result = await controller.findAll();

      expect(service.findAll).toHaveBeenCalled();
      expect(result).toEqual(mockPlaylists);
    });
  });

  describe('findOneByUser', () => {
    it('should call service.findPlaylistsByUserId and return playlists', async () => {
      const mockPlaylists = [{ id: 1 }, { id: 2 }];
      (service.findPlaylistsByUserId as jest.Mock).mockResolvedValue(
        mockPlaylists,
      );

      const result = await controller.findOneByUser('1');

      expect(service.findPlaylistsByUserId).toHaveBeenCalledWith(1);
      expect(result).toEqual(mockPlaylists);
    });

    it('should throw NotFoundException if user not found', async () => {
      (service.findPlaylistsByUserId as jest.Mock).mockRejectedValue(
        new NotFoundException(),
      );

      await expect(controller.findOneByUser('1')).rejects.toThrow(
        NotFoundException,
      );
    });
  });
});
