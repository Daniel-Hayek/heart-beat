import {
  BadRequestException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
import { CreateMoodTrackingDto } from './dto/create-mood-tracking.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/entities/user.entity';
import { MoodTracking } from 'src/entities/mood-tracking.entity';
import { Repository } from 'typeorm';
import { Journal } from 'src/entities/journal.entity';
import { EventEmitter2, OnEvent } from '@nestjs/event-emitter';
import { Mood } from 'src/entities/moods.entity';

@Injectable()
export class MoodTrackingService {
  constructor(
    @InjectRepository(MoodTracking)
    private readonly trackingRepo: Repository<MoodTracking>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,

    @InjectRepository(Mood)
    private readonly moodRepo: Repository<Mood>,

    private readonly eventEmitter: EventEmitter2,
  ) {}

  async create(createMoodTrackingDto: CreateMoodTrackingDto) {
    const user = await this.userRepo.findOne({
      where: { id: createMoodTrackingDto.userId },
    });

    if (user == null) {
      throw new NotFoundException('No user with such an ID');
    }

    if (createMoodTrackingDto.score > 10 || createMoodTrackingDto.score < 0) {
      throw new BadRequestException('Score can only be between 0 and 10');
    }

    const moodTracking = this.trackingRepo.create({
      source: createMoodTrackingDto.source,
      mood: createMoodTrackingDto.mood,
      score: createMoodTrackingDto.score,
      user,
    });

    return this.trackingRepo.save(moodTracking);
  }

  async getMoodsByUserId(id: number) {
    const user = await this.userRepo.findOne({ where: { id } });

    if (user == null) {
      throw new NotFoundException('No user with such an ID');
    }

    const moodTrackings = this.trackingRepo.find({ where: { user: { id } } });

    return moodTrackings;
  }

  @OnEvent('journal.created')
  async handleJournalCreation(journal: Journal) {
    const moods = journal.moods_assigned?.split(',').map((m) => m.trim());
    let average = 0;

    for (const m of moods!) {
      const curMood = await this.moodRepo.findOne({
        where: { name: m },
        select: ['score'],
      });

      average += curMood!.score;
    }

    average = average / 3;

    const moodTracking = this.trackingRepo.create({
      source: 'Journal',
      mood: journal.moods_assigned!,
      score: parseFloat(average.toFixed(1)),
      user: journal.user,
    });

    this.eventEmitter.emit('mood.tracked', moodTracking);

    return this.trackingRepo.save(moodTracking);
  }

  async getLastMood(id: number) {
    const mood = await this.trackingRepo.findOne({
      where: { user: { id } },
      order: { timestamp: 'DESC' },
    });

    return mood?.mood;
  }

  async logMood(createMoodTrackingDto: CreateMoodTrackingDto) {
    const user = await this.userRepo.findOne({
      where: { id: createMoodTrackingDto.userId },
    });

    if (user == null) {
      throw new NotFoundException('No user with such an ID');
    }

    if (createMoodTrackingDto.score > 10 || createMoodTrackingDto.score < 0) {
      throw new BadRequestException('Score can only be between 0 and 10');
    }

    const moodTracking = this.trackingRepo.create({
      source: 'AI Agent',
      mood: createMoodTrackingDto.mood,
      score: createMoodTrackingDto.score,
      user,
    });

    this.eventEmitter.emit('mood.tracked', moodTracking);

    return this.trackingRepo.save(moodTracking);
  }
}
