import { Process, Processor } from '@nestjs/bull';
import { JournalsService } from './journals.service';
import { Job } from 'bull';

@Processor('journal-processing')
export class JournalsProcessor {
  constructor(private readonly journalService: JournalsService) {}

  @Process()
  async handleJournalProcessing(job: Job<{ journalId: number }>) {
    const { journalId } = job.data;

    const savedJournal = await this.journalService.
  }
}
