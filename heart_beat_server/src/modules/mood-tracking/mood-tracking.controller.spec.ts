import { Test, TestingModule } from '@nestjs/testing';
import { MoodTrackingController } from './mood-tracking.controller';
import { MoodTrackingService } from './mood-tracking.service';
import { CreateMoodTrackingDto } from './dto/create-mood-tracking.dto';
import { NotFoundException } from '@nestjs/common';

describe('MoodTrackingController', () => {
  let controller: MoodTrackingController;
  let service: Partial<MoodTrackingService>;

  beforeEach(async () => {
    service = {
      create: jest.fn(),
      getMoodsByUserId: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [MoodTrackingController],
      providers: [{ provide: MoodTrackingService, useValue: service }],
    }).compile();

    controller = module.get<MoodTrackingController>(MoodTrackingController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  describe('create', () => {
    it('should call service.create and return the result', async () => {
      const dto: CreateMoodTrackingDto = {
        userId: 21,
        source: 'Journal',
        mood: 'Happy',
        score: 7,
      };
      const mockResult = { id: 1, ...dto };
      (service.create as jest.Mock).mockResolvedValue(mockResult);

      const result = await controller.create(dto);
      expect(result).toEqual(mockResult);
      expect(service.create).toHaveBeenCalledWith(dto);
    });
  });

  describe('getMoodsByUserId', () => {
    it('should call service.getMoodsByUserId and return the result', async () => {
      const mockResult = [{ id: 1, mood: 'Happy', score: 7 }];
      (service.getMoodsByUserId as jest.Mock).mockResolvedValue(mockResult);

      const result = await controller.getMoodsByUserId('21');
      expect(result).toEqual(mockResult);
      expect(service.getMoodsByUserId).toHaveBeenCalledWith(21);
    });

    it('should throw NotFoundException if user not found', async () => {
      (service.getMoodsByUserId as jest.Mock).mockRejectedValue(
        new NotFoundException(),
      );
      await expect(controller.getMoodsByUserId('99')).rejects.toThrow(
        NotFoundException,
      );
    });
  });
});
