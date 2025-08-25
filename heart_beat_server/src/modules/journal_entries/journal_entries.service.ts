import { Injectable } from '@nestjs/common';
import { CreateJournalEntryDto } from './dto/create-journal_entry.dto';
import { UpdateJournalEntryDto } from './dto/update-journal_entry.dto';

@Injectable()
export class JournalEntriesService {
  create(createJournalEntryDto: CreateJournalEntryDto) {
    return 'This action adds a new journalEntry';
  }

  findAll() {
    return `This action returns all journalEntries`;
  }

  findOne(id: number) {
    return `This action returns a #${id} journalEntry`;
  }

  update(id: number, updateJournalEntryDto: UpdateJournalEntryDto) {
    return `This action updates a #${id} journalEntry`;
  }

  remove(id: number) {
    return `This action removes a #${id} journalEntry`;
  }
}
