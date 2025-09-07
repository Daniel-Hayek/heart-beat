import { Module } from '@nestjs/common';
import { MoodTrackingService } from './mood-tracking.service';
import { MoodTrackingController } from './mood-tracking.controller';
import { MoodTracking } from 'src/entities/mood-tracking.entity';
import { User } from 'src/entities/user.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([MoodTracking, User])],
  controllers: [MoodTrackingController],
  providers: [MoodTrackingService],
})
export class MoodTrackingModule {}
