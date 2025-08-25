import { Module } from '@nestjs/common';
import { JournalEntriesService } from './journal_entries.service';
import { JournalEntriesController } from './journal_entries.controller';

@Module({
  controllers: [JournalEntriesController],
  providers: [JournalEntriesService],
})
export class JournalEntriesModule {}
