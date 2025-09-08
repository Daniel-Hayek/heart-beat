import { Test, TestingModule } from '@nestjs/testing';
import { MoodsController } from './moods.controller';
import { MoodsService } from './moods.service';
import { MoodsModule } from './moods.module';
import { CreateMoodDto } from './dto/create-mood.dto';

describe('MoodsController', () => {
  let controller: MoodsController;
  let service: MoodsService;

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
      imports: [MoodsModule],
      controllers: [MoodsController],
      providers: [{ provide: MoodsService, useValue: mockService }],
    }).compile();

    controller = module.get<MoodsController>(MoodsController);
    service = module.get<MoodsService>(MoodsService);
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
      mockService.update.mockResolvedValue({ ...mockMood, name: 'Sad' });
      const result = await controller.update('1', { name: 'Sad' });
      expect(result).toEqual({ ...mockMood, name: 'Sad' });
      expect(mockService.update).toHaveBeenCalledWith(1, { name: 'Sad' });
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
