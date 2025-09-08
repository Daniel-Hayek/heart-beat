import { Test, TestingModule } from '@nestjs/testing';
import { MoodsService } from './moods.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Mood } from './mood.entity';
import { Repository } from 'typeorm';
import { CreateMoodDto } from './dto/create-mood.dto';
import { MoodsModule } from './moods.module';

describe('MoodsService', () => {
  let service: MoodsService;
  let repository: Repository<Mood>;

  const mockMood = { id: 1, name: 'Happy' };

  const mockRepo = {
    create: jest.fn(),
    save: jest.fn(),
    find: jest.fn(),
    findOne: jest.fn(),
    update: jest.fn(),
    delete: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [MoodsModule],
      providers: [
        MoodsService,
        { provide: getRepositoryToken(Mood), useValue: mockRepo },
      ],
    }).compile();

    service = module.get<MoodsService>(MoodsService);
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
      const dto: CreateMoodDto = { name: 'Happy' };
      mockRepo.create.mockReturnValue(mockMood);
      mockRepo.save.mockResolvedValue(mockMood);

      const result = await service.create(dto);

      expect(result).toEqual(mockMood);
      expect(mockRepo.create).toHaveBeenCalledWith(dto);
      expect(mockRepo.save).toHaveBeenCalledWith(mockMood);
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
      mockRepo.findOne.mockResolvedValue({ ...mockMood, name: 'Sad' });
      const result = await service.update(1, { name: 'Sad' });
      expect(result).toEqual({ ...mockMood, name: 'Sad' });
      expect(mockRepo.update).toHaveBeenCalledWith(1, { name: 'Sad' });
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
