import { Module } from '@nestjs/common';
import { ReferenceJournalsService } from './reference-journals.service';
import { ReferenceJournalsController } from './reference-journals.controller';

@Module({
  controllers: [ReferenceJournalsController],
  providers: [ReferenceJournalsService],
})
export class ReferenceJournalsModule {}
