import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { MoodTrackingService } from './mood-tracking.service';
import { CreateMoodTrackingDto } from './dto/create-mood-tracking.dto';

@Controller('mood-tracking')
export class MoodTrackingController {
  constructor(private readonly moodTrackingService: MoodTrackingService) {}

  @Post()
  create(@Body() createMoodTrackingDto: CreateMoodTrackingDto) {
    return this.moodTrackingService.create(createMoodTrackingDto);
  }

  @Get(':id')
  getMoodsByUserId(@Param('id') id: string) {
    return this.moodTrackingService.findOne(+id);
  }
}
