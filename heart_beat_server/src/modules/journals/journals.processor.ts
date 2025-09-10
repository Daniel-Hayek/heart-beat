import { Process, Processor } from '@nestjs/bull';
import { JournalsService } from './journals.service';
import type { Job } from 'bull';
import { JournalsChunks } from './journals-chunks.service';
import { EventEmitter2 } from '@nestjs/event-emitter';

@Processor('journal-processing')
export class JournalsProcessor {
  constructor(
    private readonly journalService: JournalsService,
    private readonly eventEmitter: EventEmitter2,
  ) {}

  @Process()
  async handleJournalProcessing(job: Job<{ journalId: number }>) {
    const { journalId } = job.data;

    const savedJournal = await this.journalService.find(journalId);

    const chunks = JournalsChunks.chunkJournal(savedJournal!);

    const embeddings = await JournalsChunks.embedJournal(chunks);

    const refJournals = await this.journalService.getRefernceJournals();

    const scores = JournalsChunks.determineJournalMood(embeddings, refJournals);

    savedJournal!.moods_assigned =
      scores[0].mood + ', ' + scores[1].mood + ', ' + scores[2].mood;

    await this.journalService.assignMoods(savedJournal!);

    this.eventEmitter.emit('journal.created', savedJournal!);
  }
}
