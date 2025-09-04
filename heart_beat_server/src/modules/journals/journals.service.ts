import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateJournalDto } from './dto/create-journal.dto';
import { Journal } from 'src/entities/journal.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from 'src/entities/user.entity';

@Injectable()
export class JournalsService {
  constructor(
    @InjectRepository(Journal)
    private readonly journalRepo: Repository<Journal>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
  ) {}

  async create(createJournalDto: CreateJournalDto) {
    const user = await this.userRepo.findOne({
      where: { id: createJournalDto.userId },
    });

    if (user == null) {
      throw new NotFoundException('No user with that ID');
    }

    const journal = this.journalRepo.create({
      title: createJournalDto.title,
      content: createJournalDto.content,
      user,
    });

    return this.journalRepo.save(journal);
  }

  async findAll() {
    return await this.journalRepo.find();
  }

  async findJournalsByUserId(userId: number) {
    const user = await this.userRepo.findOne({ where: { id: userId } });

    if (user == null) {
      throw new NotFoundException('No user with that ID');
    }

    const journals = await this.journalRepo.find({
      where: { user: { id: userId } },
    });

    return journals;
  }

  async remove(id: number) {
    const result = await this.journalRepo.delete(id);

    if (result.affected == 0) {
      throw new NotFoundException(`Journal ${id} does not exist`);
    }

    return `Journal ${id} deleted`;
  }
}
