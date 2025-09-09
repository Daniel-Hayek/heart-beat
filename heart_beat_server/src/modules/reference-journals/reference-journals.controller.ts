import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { ReferenceJournalsService } from './reference-journals.service';
import { CreateReferenceJournalDto } from './dto/create-reference-journal.dto';

@Controller('reference-journals')
export class ReferenceJournalsController {
  constructor(
    private readonly referenceJournalsService: ReferenceJournalsService,
  ) {}

  @Post()
  create(@Body() createReferenceJournalDto: CreateReferenceJournalDto) {
    return this.referenceJournalsService.create(createReferenceJournalDto);
  }

  @Get()
  findAll() {
    return this.referenceJournalsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.referenceJournalsService.findOne(+id);
  }
}
