import { Controller, Get, Post, Body, Param, Delete } from '@nestjs/common';
import { JournalsService } from './journals.service';
import { CreateJournalDto } from './dto/create-journal.dto';
import { ApiBody, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('Journal Endpoints')
@Controller('journals')
export class JournalsController {
  constructor(private readonly journalsService: JournalsService) {}

  @ApiOperation({ summary: 'Create a new journal entry for a user' })
  @ApiResponse({ status: 201, description: 'New journal created successfully' })
  @ApiResponse({ status: 404, description: 'No user with that ID' })
  @ApiBody({ type: CreateJournalDto })
  @Post()
  create(@Body() createJournalDto: CreateJournalDto) {
    return this.journalsService.create(createJournalDto);
  }

  @ApiOperation({
    summary: 'Return a list of all journals without their users',
  })
  @ApiResponse({
    status: 200,
    description: 'List of journals',
  })
  @Get()
  findAll() {
    return this.journalsService.findAll();
  }

  @ApiOperation({
    summary: 'Return a journal entries by a user`s ID',
  })
  @ApiResponse({
    status: 200,
    description: 'List of journals belonging to one user',
  })
  @Get(':id')
  findOne(@Param('id') userId: string) {
    return this.journalsService.findJournalsByUserId(+userId);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.journalsService.remove(+id);
  }
}
