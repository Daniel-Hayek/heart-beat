import { Injectable } from '@nestjs/common';
import { CreateReferenceJournalDto } from './dto/create-reference-journal.dto';
import { UpdateReferenceJournalDto } from './dto/update-reference-journal.dto';

@Injectable()
export class ReferenceJournalsService {
  create(createReferenceJournalDto: CreateReferenceJournalDto) {
    return 'This action adds a new referenceJournal';
  }

  findAll() {
    return `This action returns all referenceJournals`;
  }

  findOne(id: number) {
    return `This action returns a #${id} referenceJournal`;
  }

  update(id: number, updateReferenceJournalDto: UpdateReferenceJournalDto) {
    return `This action updates a #${id} referenceJournal`;
  }

  remove(id: number) {
    return `This action removes a #${id} referenceJournal`;
  }
}
