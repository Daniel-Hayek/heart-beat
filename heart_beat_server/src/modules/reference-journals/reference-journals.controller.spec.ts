import { Test, TestingModule } from '@nestjs/testing';
import { ReferenceJournalsController } from './reference-journals.controller';
import { ReferenceJournalsService } from './reference-journals.service';

describe('ReferenceJournalsController', () => {
  let controller: ReferenceJournalsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [ReferenceJournalsController],
      providers: [ReferenceJournalsService],
    }).compile();

    controller = module.get<ReferenceJournalsController>(ReferenceJournalsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
