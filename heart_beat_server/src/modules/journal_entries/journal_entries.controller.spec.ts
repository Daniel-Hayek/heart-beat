import { Test, TestingModule } from '@nestjs/testing';
import { JournalEntriesController } from './journal_entries.controller';
import { JournalEntriesService } from './journal_entries.service';

describe('JournalEntriesController', () => {
  let controller: JournalEntriesController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [JournalEntriesController],
      providers: [JournalEntriesService],
    }).compile();

    controller = module.get<JournalEntriesController>(JournalEntriesController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
