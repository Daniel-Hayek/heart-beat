import { Test, TestingModule } from '@nestjs/testing';
import { MoodService } from './moods.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Mood } from './mood.entity';
import { Repository } from 'typeorm';

describe('MoodService', () => {
  let service: MoodService;
  let repository: Repository<Mood>;

  const mockMood = { id: 1, mood: 'Happy' };

  const mockRepo = {
    save: jest.fn(),
    find: jest.fn(),
    findOne: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [
        MoodService,
        { provide: getRepositoryToken(Mood), useValue: mockRepo },
      ],
    }).compile();

    service = module.get<MoodService>(MoodService);
    repository = module.get<Repository<Mood>>(getRepositoryToken(Mood));
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('create', () => {
    it('should create and return a mood', async () => {
      mockRepo.save.mockResolvedValue(mockMood);
      const result = await service.create({ mood: 'Happy' });
      expect(result).toEqual(mockMood);
      expect(mockRepo.save).toHaveBeenCalledWith({ mood: 'Happy' });
    });
  });

  describe('findAll', () => {
    it('should return a list of moods', async () => {
      mockRepo.find.mockResolvedValue([mockMood]);
      const result = await service.findAll();
      expect(result).toEqual([mockMood]);
      expect(mockRepo.find).toHaveBeenCalled();
    });
  });

  describe('findOne', () => {
    it('should return a mood by id', async () => {
      mockRepo.findOne.mockResolvedValue(mockMood);
      const result = await service.findOne(1);
      expect(result).toEqual(mockMood);
      expect(mockRepo.findOne).toHaveBeenCalledWith({ where: { id: 1 } });
    });
  });

  describe('update', () => {
    it('should update and return the mood', async () => {
      mockRepo.update.mockResolvedValue({ affected: 1 });
      mockRepo.findOne.mockResolvedValue({ ...mockMood, mood: 'Sad' });
      const result = await service.update(1, { mood: 'Sad' });
      expect(result).toEqual({ ...mockMood, mood: 'Sad' });
      expect(mockRepo.update).toHaveBeenCalledWith(1, { mood: 'Sad' });
    });
  });

  describe('remove', () => {
    it('should delete the mood', async () => {
      mockRepo.delete.mockResolvedValue({ affected: 1 });
      const result = await service.remove(1);
      expect(result).toEqual({ affected: 1 });
      expect(mockRepo.delete).toHaveBeenCalledWith(1);
    });
  });
});
