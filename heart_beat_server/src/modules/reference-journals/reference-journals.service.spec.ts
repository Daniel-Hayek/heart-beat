import { Test, TestingModule } from '@nestjs/testing';
import { ReferenceJournalsService } from './reference-journals.service';

describe('ReferenceJournalsService', () => {
  let service: ReferenceJournalsService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [ReferenceJournalsService],
    }).compile();

    service = module.get<ReferenceJournalsService>(ReferenceJournalsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
