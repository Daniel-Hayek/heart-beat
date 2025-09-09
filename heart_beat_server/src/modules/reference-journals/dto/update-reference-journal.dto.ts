import { PartialType } from '@nestjs/swagger';
import { CreateReferenceJournalDto } from './create-reference-journal.dto';

export class UpdateReferenceJournalDto extends PartialType(CreateReferenceJournalDto) {}
