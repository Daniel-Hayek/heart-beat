import { Controller, Get, Post, Body, Param, UseGuards } from '@nestjs/common';
import { MoodTrackingService } from './mood-tracking.service';
import { CreateMoodTrackingDto } from './dto/create-mood-tracking.dto';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@ApiTags('User Mood Tracking Endpoints')
@UseGuards(JwtAuthGuard)
@ApiBearerAuth()
@Controller('mood-tracking')
export class MoodTrackingController {
  constructor(private readonly moodTrackingService: MoodTrackingService) {}

  @ApiOperation({ summary: 'Create a new mood entry for a user' })
  @ApiResponse({ status: 201, description: 'Mood tracked successfully' })
  @ApiResponse({ status: 400, description: 'Score must be between 0 and 10' })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({ status: 404, description: 'No user with that ID' })
  @ApiBody({ type: CreateMoodTrackingDto })
  @Post()
  create(@Body() createMoodTrackingDto: CreateMoodTrackingDto) {
    return this.moodTrackingService.create(createMoodTrackingDto);
  }

  @ApiOperation({ summary: 'Fetch all tracked moods for a user' })
  @ApiResponse({ status: 200, description: 'List of user`s moods' })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({ status: 404, description: 'No user with that ID' })
  @Get(':id')
  getMoodsByUserId(@Param('id') id: string) {
    return this.moodTrackingService.getMoodsByUserId(+id);
  }
}
