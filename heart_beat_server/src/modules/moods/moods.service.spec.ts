import { Test, TestingModule } from '@nestjs/testing';
import { MoodsService } from './moods.service';
import { getRepositoryToken } from '@nestjs/typeorm';
import { Mood } from 'src/entities/moods.entity';
import { CreateMoodDto } from './dto/create-mood.dto';
import { UpdateMoodDto } from './dto/update-mood.dto';
import { ConflictException, NotFoundException } from '@nestjs/common';

describe('MoodsService', () => {
  let service: MoodsService;

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
      providers: [
        MoodsService,
        { provide: getRepositoryToken(Mood), useValue: mockRepo },
      ],
    }).compile();

    service = module.get<MoodsService>(MoodsService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('create', () => {
    it('should create and return a mood if it does not exist', async () => {
      const dto: CreateMoodDto = { name: 'Happy' };
      mockRepo.findOne.mockResolvedValue(null);
      mockRepo.create.mockReturnValue(mockMood);
      mockRepo.save.mockResolvedValue(mockMood);

      const result = await service.create(dto);

      expect(result).toEqual(mockMood);
      expect(mockRepo.create).toHaveBeenCalledWith({ name: dto.name });
      expect(mockRepo.save).toHaveBeenCalledWith(mockMood);
    });

    it('should throw ConflictException if mood exists', async () => {
      const dto: CreateMoodDto = { name: 'Happy' };
      mockRepo.findOne.mockResolvedValue(mockMood);

      await expect(service.create(dto)).rejects.toThrow(ConflictException);
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

    it('should throw NotFoundException if mood does not exist', async () => {
      mockRepo.findOne.mockResolvedValue(null);
      await expect(service.findOne(1)).rejects.toThrow(NotFoundException);
    });
  });

  describe('update', () => {
    it('should update and return the mood', async () => {
      const updateDto: UpdateMoodDto = { name: 'Sad' };
      mockRepo.findOne.mockResolvedValue(mockMood);
      mockRepo.save.mockResolvedValue({ ...mockMood, name: 'Sad' });

      const result = await service.update(1, updateDto);
      expect(result).toEqual({ ...mockMood, name: 'Sad' });
      expect(mockRepo.save).toHaveBeenCalledWith({ ...mockMood, ...updateDto });
    });
  });

  describe('remove', () => {
    it('should delete the mood and return success message', async () => {
      mockRepo.delete.mockResolvedValue({ affected: 1 });
      const result = await service.remove(1);
      expect(result).toEqual('Mood deleted successfully');
      expect(mockRepo.delete).toHaveBeenCalledWith(1);
    });

    it('should throw NotFoundException if mood does not exist', async () => {
      mockRepo.delete.mockResolvedValue({ affected: 0 });
      await expect(service.remove(1)).rejects.toThrow(NotFoundException);
    });
  });
});
