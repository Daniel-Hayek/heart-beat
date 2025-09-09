import { Injectable } from '@nestjs/common';
import { CreateReferenceJournalDto } from './dto/create-reference-journal.dto';
import { UpdateReferenceJournalDto } from './dto/update-reference-journal.dto';
import { Repository } from 'typeorm';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';
import { InjectRepository } from '@nestjs/typeorm';

@Injectable()
export class ReferenceJournalsService {
  constructor(
    @InjectRepository(ReferenceJournal)
    private readonly refJournalRepo: Repository<ReferenceJournal>,
  ) {}

  create(createReferenceJournalDto: CreateReferenceJournalDto) {
    return 'This action adds a new referenceJournal';
  }

  findAll() {
    return this.refJournalRepo.find();
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
