import { Test, TestingModule } from '@nestjs/testing';
import { MoodTrackingService } from './mood-tracking.service';

describe('MoodTrackingService', () => {
  let service: MoodTrackingService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [MoodTrackingService],
    }).compile();

    service = module.get<MoodTrackingService>(MoodTrackingService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
