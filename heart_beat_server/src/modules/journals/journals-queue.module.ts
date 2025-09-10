import { Module } from '@nestjs/common';
import { BullModule } from '@nestjs/bull';
import { JournalsService } from './journals.service';
import { JournalsProcessor } from './journals.processor';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Journal } from 'src/entities/journal.entity';
import { User } from 'src/entities/user.entity';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';

@Module({
  imports: [
    BullModule.registerQueue({
      name: 'journal-processing',
    }),
    TypeOrmModule.forFeature([Journal, User, ReferenceJournal]),
  ],
  providers: [JournalsProcessor, JournalsService],
  exports: [BullModule],
})
export class JournalsQueueModule {}
