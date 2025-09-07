import { Test, TestingModule } from '@nestjs/testing';
import { SongsService } from './songs.service';
import { Repository } from 'typeorm';
import { Song } from 'src/entities/song.entity';
import { User } from 'src/entities/user.entity';
import { getRepositoryToken } from '@nestjs/typeorm';
import { CreateSongDto } from './dto/create-song.dto';

describe('SongsService', () => {
  let service: SongsService;
  let songRepo: Partial<Repository<Song>>;
  let userRepo: Partial<Repository<User>>;

  beforeEach(async () => {
    songRepo = {
      create: jest.fn(),
      save: jest.fn(),
      find: jest.fn(),
      findOne: jest.fn(),
      delete: jest.fn(),
      count: jest.fn(),
    };

    userRepo = {
      findOne: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        SongsService,
        { provide: getRepositoryToken(Song), useValue: songRepo },
        { provide: getRepositoryToken(User), useValue: userRepo },
      ],
    }).compile();

    service = module.get<SongsService>(SongsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('create', () => {
    it('should create and save a song if user exists', async () => {
      const dto: CreateSongDto = {
        title: 'Test',
        artist: 'Test',
        duration: 0,
        song_url: 'Test',
      };
      const mockUser = { id: 1 } as User;
      const mockSong: Song = {
        id: 1,
        title: dto.title,
        artist: dto.artist,
        duration: dto.duration,
        song_url: dto.song_url,
        created_at: new Date(),
        updated_at: new Date(),
        playlistSongs: [],
        user: mockUser,
      } as Song;

      (userRepo.findOne as jest.Mock).mockResolvedValue(mockUser);
      (songRepo.create as jest.Mock).mockReturnValue(mockSong);
      (songRepo.save as jest.Mock).mockResolvedValue(mockSong);

      const result = await service.create(dto);
      expect(result).toEqual(mockSong);

      expect(songRepo.create).toHaveBeenCalledWith({
        title: dto.title,
        artist: dto.artist,
        duration: dto.duration,
        song_url: dto.song_url,
      });

      expect(songRepo.save).toHaveBeenCalledWith(mockSong);
    });
  });

  describe('findAll', () => {
    it('should return all songs', async () => {
      const mockSongs = [{ id: 1 }, { id: 2 }] as Song[];
      (songRepo.find as jest.Mock).mockResolvedValue(mockSongs);

      const result = await service.findAll();
      expect(result).toEqual(mockSongs);
    });
  });
});
