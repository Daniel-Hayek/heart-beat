import { Injectable, NotFoundException } from '@nestjs/common';
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

    return 'This action adds a new moodTracking';
  }

  getMoodsByUserId(id: number) {
    return `This action returns a #${id} moodTracking`;
  }
}
