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
  @ApiBody({ type: CreateJournalDto })
  @Post()
  create(@Body() createJournalDto: CreateJournalDto) {
    return this.journalsService.create(createJournalDto);
  }

  @Get()
  findAll() {
    return this.journalsService.findAll();
  }

  // @Get(':id')
  // findOne(@Param('id') id: string) {
  //   return this.journalsService.findOne(+id);
  // }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.journalsService.remove(+id);
  }
}
