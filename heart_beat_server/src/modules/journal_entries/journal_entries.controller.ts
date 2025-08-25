import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { JournalEntriesService } from './journal_entries.service';
import { CreateJournalEntryDto } from './dto/create-journal_entry.dto';
import { UpdateJournalEntryDto } from './dto/update-journal_entry.dto';

@Controller('journal-entries')
export class JournalEntriesController {
  constructor(private readonly journalEntriesService: JournalEntriesService) {}

  @Post()
  create(@Body() createJournalEntryDto: CreateJournalEntryDto) {
    return this.journalEntriesService.create(createJournalEntryDto);
  }

  @Get()
  findAll() {
    return this.journalEntriesService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.journalEntriesService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateJournalEntryDto: UpdateJournalEntryDto) {
    return this.journalEntriesService.update(+id, updateJournalEntryDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.journalEntriesService.remove(+id);
  }
}
