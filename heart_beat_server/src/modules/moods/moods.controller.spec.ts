import { Test, TestingModule } from '@nestjs/testing';
import { MoodsController } from './moods.controller';
import { MoodsService } from './moods.service';
import { CreateMoodDto } from './dto/create-mood.dto';
import { UpdateMoodDto } from './dto/update-mood.dto';
import { ConflictException, NotFoundException } from '@nestjs/common';

describe('MoodsController', () => {
  let controller: MoodsController;

  const mockMood = { id: 1, name: 'Happy' };

  const mockService = {
    create: jest.fn(),
    findAll: jest.fn(),
    findOne: jest.fn(),
    update: jest.fn(),
    remove: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MoodsController],
      providers: [{ provide: MoodsService, useValue: mockService }],
    }).compile();

    controller = module.get<MoodsController>(MoodsController);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('create', () => {
    it('should call service.create', async () => {
      const dto: CreateMoodDto = { name: 'Happy' };
      mockService.create.mockResolvedValue(mockMood);

      const result = await controller.create(dto);

      expect(result).toEqual(mockMood);
      expect(mockService.create).toHaveBeenCalledWith(dto);
    });

    it('should throw ConflictException when mood exists', async () => {
      const dto: CreateMoodDto = { name: 'Happy' };
      mockService.create.mockRejectedValue(new ConflictException());
      await expect(controller.create(dto)).rejects.toThrow(ConflictException);
    });
  });

  describe('findAll', () => {
    it('should call service.findAll', async () => {
      mockService.findAll.mockResolvedValue([mockMood]);
      const result = await controller.findAll();
      expect(result).toEqual([mockMood]);
      expect(mockService.findAll).toHaveBeenCalled();
    });
  });

  describe('findOne', () => {
    it('should call service.findOne', async () => {
      mockService.findOne.mockResolvedValue(mockMood);
      const result = await controller.findOne('1');
      expect(result).toEqual(mockMood);
      expect(mockService.findOne).toHaveBeenCalledWith(1);
    });

    it('should throw NotFoundException if mood not found', async () => {
      mockService.findOne.mockRejectedValue(new NotFoundException());
      await expect(controller.findOne('1')).rejects.toThrow(NotFoundException);
    });
  });

  describe('update', () => {
    it('should call service.update', async () => {
      const updateDto: UpdateMoodDto = { name: 'Sad' };
      mockService.update.mockResolvedValue({ id: 1, name: 'Sad' });

      const result = await controller.update('1', updateDto);
      expect(result).toEqual({ id: 1, name: 'Sad' });
      expect(mockService.update).toHaveBeenCalledWith(1, updateDto);
    });
  });

  describe('remove', () => {
    it('should call service.remove', async () => {
      mockService.remove.mockResolvedValue('Mood deleted successfully');
      const result = await controller.remove('1');
      expect(result).toEqual('Mood deleted successfully');
      expect(mockService.remove).toHaveBeenCalledWith(1);
    });

    it('should throw NotFoundException if mood does not exist', async () => {
      mockService.remove.mockRejectedValue(new NotFoundException());
      await expect(controller.remove('1')).rejects.toThrow(NotFoundException);
    });
  });
});
