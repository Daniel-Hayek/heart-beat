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
    return await this.journalRepo.find({ relations: ['user'] });
  }

  // async findOne(id: number) {
  //   const journal = this.journalRepo.findOne({})
  // }

  remove(id: number) {
    return `This action removes a #${id} journal`;
  }
}
