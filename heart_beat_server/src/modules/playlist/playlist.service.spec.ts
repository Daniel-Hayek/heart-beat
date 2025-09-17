import { Test, TestingModule } from '@nestjs/testing';
import { PlaylistService } from './playlist.service';
import { Repository } from 'typeorm';
import { Playlist } from 'src/entities/playlist.entity';
import { User } from 'src/entities/user.entity';
import { getRepositoryToken } from '@nestjs/typeorm';
import { CreatePlaylistDto } from './dto/create-playlist.dto';
import { NotFoundException } from '@nestjs/common';
import { EventEmitter2 } from '@nestjs/event-emitter';

describe('PlaylistService', () => {
  let service: PlaylistService;
  let playlistRepo: Partial<Repository<Playlist>>;
  let userRepo: Partial<Repository<User>>;

  beforeEach(async () => {
    playlistRepo = {
      create: jest.fn(),
      save: jest.fn(),
      find: jest.fn(),
    };

    userRepo = {
      findOne: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        PlaylistService,
        { provide: getRepositoryToken(Playlist), useValue: playlistRepo },
        { provide: getRepositoryToken(User), useValue: userRepo },
        {
          provide: EventEmitter2,
          useValue: { emit: jest.fn() },
        },
      ],
    }).compile();

    service = module.get<PlaylistService>(PlaylistService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('create', () => {
    it('should create and return a playlist if user exists', async () => {
      const dto: CreatePlaylistDto = {
        name: 'My Playlist',
        userId: 1,
        is_auto_generated: false,
      };
      const mockUser: User = { id: 1 } as User;
      const mockPlaylist: Playlist = {
        id: 1,
        name: dto.name,
        user: mockUser,
      } as Playlist;

      (userRepo.findOne as jest.Mock).mockResolvedValue(mockUser);
      (playlistRepo.create as jest.Mock).mockReturnValue(mockPlaylist);
      (playlistRepo.save as jest.Mock).mockResolvedValue(mockPlaylist);

      const result = await service.create(dto);

      expect(userRepo.findOne).toHaveBeenCalledWith({
        where: { id: dto.userId },
      });
      expect(playlistRepo.create).toHaveBeenCalledWith({
        name: dto.name,
        user: mockUser,
      });
      expect(playlistRepo.save).toHaveBeenCalledWith(mockPlaylist);

      expect(result).toHaveProperty('id', 1);
      expect(result).toHaveProperty('name', 'My Playlist');
    });

    it('should throw NotFoundException if user does not exist', async () => {
      const dto: CreatePlaylistDto = {
        name: 'My Playlist',
        userId: 1,
        is_auto_generated: false,
      };
      (userRepo.findOne as jest.Mock).mockResolvedValue(null);

      await expect(service.create(dto)).rejects.toThrow(NotFoundException);
    });
  });

  describe('findAll', () => {
    it('should return all playlists', async () => {
      const mockPlaylists = [{ id: 1 }, { id: 2 }] as Playlist[];
      (playlistRepo.find as jest.Mock).mockResolvedValue(mockPlaylists);

      const result = await service.findAll();

      expect(result).toEqual(mockPlaylists);
      expect(playlistRepo.find).toHaveBeenCalled();
    });
  });

  describe('findPlaylistsByUserId', () => {
    it('should return playlists for a valid user', async () => {
      const mockUser: User = { id: 1 } as User;
      const mockPlaylists: Playlist[] = [
        { id: 1, user: mockUser },
        { id: 2, user: mockUser },
      ] as Playlist[];

      (userRepo.findOne as jest.Mock).mockResolvedValue(mockUser);
      (playlistRepo.find as jest.Mock).mockResolvedValue(mockPlaylists);

      const result = await service.findPlaylistsByUserId(1, 1);

      expect(userRepo.findOne).toHaveBeenCalledWith({ where: { id: 1 } });
      expect(playlistRepo.find).toHaveBeenCalledWith(
        expect.objectContaining({
          where: { user: { id: 1 } },
          take: 5,
          skip: 0,
          order: { created_at: 'DESC' },
        }),
      );
      expect(result).toEqual(mockPlaylists);
    });

    it('should throw NotFoundException if user does not exist', async () => {
      (userRepo.findOne as jest.Mock).mockResolvedValue(null);

      await expect(service.findPlaylistsByUserId(1, 1)).rejects.toThrow(
        NotFoundException,
      );
    });
  });
});
