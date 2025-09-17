import {
  Controller,
  Get,
  Post,
  Body,
  Param,
  Delete,
  UseGuards,
} from '@nestjs/common';
import { JournalsService } from './journals.service';
import { CreateJournalDto } from './dto/create-journal.dto';
import {
  ApiBearerAuth,
  ApiBody,
  ApiOperation,
  ApiResponse,
  ApiTags,
} from '@nestjs/swagger';
import { JwtAuthGuard } from '../auth/jwt-auth.guard';

@ApiTags('Journal Endpoints')
@Controller('journals')
export class JournalsController {
  constructor(private readonly journalsService: JournalsService) {}

  @ApiOperation({ summary: 'Create a new journal entry for a user' })
  @ApiResponse({ status: 201, description: 'New journal created successfully' })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({ status: 404, description: 'No user with that ID' })
  @ApiBody({ type: CreateJournalDto })
  @Post()
  create(@Body() createJournalDto: CreateJournalDto) {
    return this.journalsService.create(createJournalDto);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Return a list of all journals without their users',
  })
  @ApiResponse({
    status: 200,
    description: 'List of journals',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @Get()
  findAll() {
    return this.journalsService.findAll();
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Return a journal entries by a user`s ID',
  })
  @ApiResponse({
    status: 200,
    description: 'List of journals belonging to one user',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({ status: 404, description: 'No user with that ID' })
  @Get(':id')
  findOne(@Param('id') userId: string) {
    return this.journalsService.findJournalsByUserId(+userId);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Delete a journal by its ID',
  })
  @ApiResponse({
    status: 200,
    description: 'Journal deleted successfully',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({ status: 404, description: 'No journal with that ID' })
  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.journalsService.remove(+id);
  }

  @UseGuards(JwtAuthGuard)
  @ApiBearerAuth()
  @ApiOperation({
    summary: 'Return the total number of journals written by this user',
  })
  @ApiResponse({
    status: 200,
    description: 'Retrieved the total number of journals',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({
    status: 404,
    description: 'No user with that ID',
  })
  @Get('number/:id')
  getNumber(@Param('id') userId: string) {
    return this.journalsService.getNumber(+userId);
  }

  @ApiOperation({
    summary: 'Return the last journal written by the user (AI Agent)',
  })
  @ApiResponse({
    status: 200,
    description: 'Retrieved the total number of journals',
  })
  @ApiResponse({
    status: 404,
    description: 'No user with that ID',
  })
  @Get('last/:id')
  getLast(@Param('id') userId: string) {
    return this.journalsService.getLast(+userId);
  }
}
