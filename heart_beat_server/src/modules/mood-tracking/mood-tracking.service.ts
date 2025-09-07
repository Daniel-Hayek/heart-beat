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

@Injectable()
export class MoodTrackingService {
  constructor(
    @InjectRepository(MoodTracking)
    private readonly trackingRepo: Repository<MoodTracking>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
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
}
