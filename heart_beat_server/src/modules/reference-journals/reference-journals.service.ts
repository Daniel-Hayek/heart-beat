import { Injectable } from '@nestjs/common';
import { Repository } from 'typeorm';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class ReferenceJournalsService {
  constructor(
    @InjectRepository(ReferenceJournal)
    private readonly refJournalRepo: Repository<ReferenceJournal>,
  ) {}

  findAll() {
    return this.refJournalRepo.find({ relations: ['moods'] });
  }
}
