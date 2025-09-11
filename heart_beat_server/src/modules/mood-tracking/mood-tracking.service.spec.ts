import { Test, TestingModule } from '@nestjs/testing';
import { MoodTrackingService } from './mood-tracking.service';
import { Repository } from 'typeorm';
import { MoodTracking } from 'src/entities/mood-tracking.entity';
import { User } from 'src/entities/user.entity';
import { getRepositoryToken } from '@nestjs/typeorm';
import { CreateMoodTrackingDto } from './dto/create-mood-tracking.dto';
import { NotFoundException } from '@nestjs/common';
import { Mood } from 'src/entities/moods.entity';
import { EventEmitter2 } from '@nestjs/event-emitter';

describe('MoodTrackingService', () => {
  let service: MoodTrackingService;
  let moodRepo: Partial<Repository<MoodTracking>>;
  let userRepo: Partial<Repository<User>>;
  let moodLabelRepo: Partial<Repository<User>>;

  beforeEach(async () => {
    moodRepo = {
      create: jest.fn(),
      save: jest.fn(),
      find: jest.fn(),
    };
    userRepo = {
      findOne: jest.fn(),
    };
    moodLabelRepo = {
      findOne: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MoodTrackingService,
        { provide: getRepositoryToken(MoodTracking), useValue: moodRepo },
        { provide: getRepositoryToken(User), useValue: userRepo },
        { provide: getRepositoryToken(Mood), useValue: moodLabelRepo },
        {
          provide: EventEmitter2,
          useValue: { emit: jest.fn() },
        },
      ],
    }).compile();

    service = module.get<MoodTrackingService>(MoodTrackingService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('create', () => {
    it('should create and save a mood tracking entry if user exists', async () => {
      const dto: CreateMoodTrackingDto = {
        userId: 21,
        source: 'Journal',
        mood: 'Melancholic and Peaceful',
        score: 4,
      };

      const mockUser = { id: 21 } as User;
      const mockMood = {
        id: 1,
        user: mockUser,
        ...dto,
        timestamp: new Date(),
      } as MoodTracking;

      (userRepo.findOne as jest.Mock).mockResolvedValue(mockUser);
      (moodRepo.create as jest.Mock).mockReturnValue(mockMood);
      (moodRepo.save as jest.Mock).mockResolvedValue(mockMood);

      const result = await service.create(dto);

      expect(result).toEqual(mockMood);
      expect(userRepo.findOne).toHaveBeenCalledWith({
        where: { id: dto.userId },
      });
      expect(moodRepo.create).toHaveBeenCalledWith({
        user: mockUser,
        score: dto.score,
        mood: dto.mood,
        source: dto.source,
      });
      expect(moodRepo.save).toHaveBeenCalledWith(mockMood);
    });

    it('should throw NotFoundException if user does not exist', async () => {
      (userRepo.findOne as jest.Mock).mockResolvedValue(null);
      const dto: CreateMoodTrackingDto = {
        userId: 99,
        source: 'Journal',
        mood: 'Sad',
        score: 2,
      };

      await expect(service.create(dto)).rejects.toThrow(NotFoundException);
    });

    it('should throw error if score is out of bounds', async () => {
      const dto: CreateMoodTrackingDto = {
        userId: 21,
        source: 'Journal',
        mood: 'Sad',
        score: 11,
      };
      const mockUser = { id: 21 } as User;
      (userRepo.findOne as jest.Mock).mockResolvedValue(mockUser);

      await expect(service.create(dto)).rejects.toThrow();
    });
  });

  describe('getMoodsByUserId', () => {
    it('should return a list of moods for a valid user', async () => {
      const mockUser = { id: 21 } as User;
      const mockMoods = [
        {
          id: 1,
          mood: 'Happy',
          score: 7,
          timestamp: new Date(),
        } as MoodTracking,
        {
          id: 2,
          mood: 'Melancholic',
          score: 4,
          timestamp: new Date(),
        } as MoodTracking,
      ];

      (userRepo.findOne as jest.Mock).mockResolvedValue(mockUser);
      (moodRepo.find as jest.Mock).mockResolvedValue(mockMoods);

      const result = await service.getMoodsByUserId(21);

      expect(result).toEqual(mockMoods);
      expect(userRepo.findOne).toHaveBeenCalledWith({ where: { id: 21 } });
      expect(moodRepo.find).toHaveBeenCalledWith({
        where: { user: { id: 21 } },
      });
    });

    it('should throw NotFoundException if user does not exist', async () => {
      (userRepo.findOne as jest.Mock).mockResolvedValue(null);
      await expect(service.getMoodsByUserId(9999)).rejects.toThrow(
        NotFoundException,
      );
    });
  });
});
