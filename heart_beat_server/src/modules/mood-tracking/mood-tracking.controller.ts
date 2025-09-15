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
@Controller('mood-tracking')
export class MoodTrackingController {
  constructor(private readonly moodTrackingService: MoodTrackingService) {}

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
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

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
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

  @ApiOperation({
    summary: 'Return the latest mood of a user (AI Agent Endpoint)',
  })
  @ApiResponse({ status: 200, description: 'Latest user mood' })
  @ApiResponse({ status: 404, description: 'No user with that ID' })
  @Get('/last/:id')
  getLastMood(@Param('id') id: string) {
    return this.moodTrackingService.getLastMood(+id);
  }
}
