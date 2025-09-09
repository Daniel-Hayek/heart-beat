import { Module } from '@nestjs/common';
import { ReferenceJournalsService } from './reference-journals.service';
import { ReferenceJournalsController } from './reference-journals.controller';
import { Mood } from 'src/entities/moods.entity';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Mood, ReferenceJournal])],
  controllers: [ReferenceJournalsController],
  providers: [ReferenceJournalsService],
})
export class ReferenceJournalsModule {}
