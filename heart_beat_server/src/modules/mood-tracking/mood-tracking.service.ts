import { Injectable } from '@nestjs/common';
import { CreateMoodTrackingDto } from './dto/create-mood-tracking.dto';
import { UpdateMoodTrackingDto } from './dto/update-mood-tracking.dto';

@Injectable()
export class MoodTrackingService {
  create(createMoodTrackingDto: CreateMoodTrackingDto) {
    return 'This action adds a new moodTracking';
  }

  findAll() {
    return `This action returns all moodTracking`;
  }

  findOne(id: number) {
    return `This action returns a #${id} moodTracking`;
  }

  update(id: number, updateMoodTrackingDto: UpdateMoodTrackingDto) {
    return `This action updates a #${id} moodTracking`;
  }

  remove(id: number) {
    return `This action removes a #${id} moodTracking`;
  }
}
