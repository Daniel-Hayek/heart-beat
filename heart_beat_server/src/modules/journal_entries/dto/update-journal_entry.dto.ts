import { PartialType } from '@nestjs/mapped-types';
import { CreateJournalEntryDto } from './create-journal_entry.dto';

export class UpdateJournalEntryDto extends PartialType(CreateJournalEntryDto) {}
