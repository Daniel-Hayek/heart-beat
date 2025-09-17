import { Controller, Get } from '@nestjs/common';
import { ReferenceJournalsService } from './reference-journals.service';
import { ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('Mood Label Endpoints (For Music Mood Labels)')
@Controller('reference-journals')
export class ReferenceJournalsController {
  constructor(
    private readonly referenceJournalsService: ReferenceJournalsService,
  ) {}

  @ApiOperation({
    summary: 'Return a list of all reference journals with their mood labels',
  })
  @ApiResponse({
    status: 200,
    description: 'List of reference journals and their moods',
  })
  @Get()
  findAll() {
    return this.referenceJournalsService.findAll();
  }
}
