import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { ReferenceJournalsService } from './reference-journals.service';
import { CreateReferenceJournalDto } from './dto/create-reference-journal.dto';
import { UpdateReferenceJournalDto } from './dto/update-reference-journal.dto';

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

  @Patch(':id')
  update(
    @Param('id') id: string,
    @Body() updateReferenceJournalDto: UpdateReferenceJournalDto,
  ) {
    return this.referenceJournalsService.update(+id, updateReferenceJournalDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.referenceJournalsService.remove(+id);
  }
}
