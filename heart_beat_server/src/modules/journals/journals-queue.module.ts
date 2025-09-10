import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bull';
import { JournalsService } from './journals.service';
import { JournalsProcessor } from './journals.processor';

@Module({
  imports: [
    BullModule.registerQueue({
      name: 'journal-processing',
    }),
  ],
  providers: [JournalsProcessor, JournalsService],
  exports: [BullModule],
})
export class JournalsQueueModule {}
