import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateJournalDto } from './dto/create-journal.dto';
import { Journal } from 'src/entities/journal.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { User } from 'src/entities/user.entity';
import { JournalsChunks } from './journals-chunks.service';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';
import { EventEmitter2 } from '@nestjs/event-emitter';

@Injectable()
export class JournalsService {
  constructor(
    @InjectRepository(Journal)
    private readonly journalRepo: Repository<Journal>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,

    @InjectRepository(ReferenceJournal)
    private readonly refJournalRepo: Repository<ReferenceJournal>,

    private readonly eventEmitter: EventEmitter2,
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

    const chunks = JournalsChunks.chunkJournal(journal);
    const embeddings = await JournalsChunks.embedJournal(chunks);

    const refJournals = await this.refJournalRepo.find({
      relations: ['moods'],
    });

    const scores = JournalsChunks.determineJournalMood(embeddings, refJournals);

    journal.moods_assigned =
      scores[0].mood + ', ' + scores[1].mood + ', ' + scores[2].mood;

    const saved = await this.journalRepo.save(journal);

    this.eventEmitter.emit('journal.created', journal);

    return saved;
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

  async getLatest(userId: number) {
    const user = await this.journalRepo.find({ where: { id: userId } });

    if (user == null) {
      throw new NotFoundException('No user with that ID');
    }

    const result = await this.journalRepo.findOne({
      where: { user: { id: userId } },
      order: { created_at: 'DESC' },
    });

    return result;
  }

  async getNumber(userId: number) {
    const user = await this.journalRepo.find({ where: { id: userId } });

    if (user == null) {
      throw new NotFoundException('No user with that ID');
    }

    const result = await this.journalRepo.count({
      where: { user: { id: userId } },
    });

    return result;
  }
}
