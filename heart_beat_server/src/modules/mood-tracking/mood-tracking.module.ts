import { Module } from '@nestjs/common';
import { MoodTrackingService } from './mood-tracking.service';
import { MoodTrackingController } from './mood-tracking.controller';
import { MoodTracking } from 'src/entities/mood-tracking.entity';
import { User } from 'src/entities/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Mood } from 'src/entities/moods.entity';

@Module({
  imports: [TypeOrmModule.forFeature([MoodTracking, User, Mood])],
  controllers: [MoodTrackingController],
  providers: [MoodTrackingService],
})
export class MoodTrackingModule {}
