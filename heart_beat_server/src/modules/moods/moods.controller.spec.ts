import { Test, TestingModule } from '@nestjs/testing';
import { MoodController } from './moods.controller';
import { MoodService } from './moods.service';

describe('MoodController', () => {
  let controller: MoodController;
  let service: MoodService;

  const mockMood = { id: 1, mood: 'Happy' };

  const mockService = {
    create: jest.fn(),
    findAll: jest.fn(),
    findOne: jest.fn(),
    update: jest.fn(),
    remove: jest.fn(),
  };

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [MoodController],
      providers: [{ provide: MoodService, useValue: mockService }],
    }).compile();

    controller = module.get<MoodController>(MoodController);
    service = module.get<MoodService>(MoodService);
  });

  afterEach(() => {
    jest.clearAllMocks();
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('create', () => {
    it('should call service.create', async () => {
      mockService.create.mockResolvedValue(mockMood);
      const result = await controller.create({ mood: 'Happy' });
      expect(result).toEqual(mockMood);
      expect(mockService.create).toHaveBeenCalledWith({ mood: 'Happy' });
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
  });

  describe('update', () => {
    it('should call service.update', async () => {
      mockService.update.mockResolvedValue({ ...mockMood, mood: 'Sad' });
      const result = await controller.update('1', { mood: 'Sad' });
      expect(result).toEqual({ ...mockMood, mood: 'Sad' });
      expect(mockService.update).toHaveBeenCalledWith(1, { mood: 'Sad' });
    });
  });

  describe('remove', () => {
    it('should call service.remove', async () => {
      mockService.remove.mockResolvedValue({ affected: 1 });
      const result = await controller.remove('1');
      expect(result).toEqual({ affected: 1 });
      expect(mockService.remove).toHaveBeenCalledWith(1);
    });
  });
});
