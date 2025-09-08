import {
  Controller,
  Get,
  Post,
  Body,
  Patch,
  Param,
  Delete,
} from '@nestjs/common';
import { MoodsService } from './moods.service';
import { CreateMoodDto } from './dto/create-mood.dto';
import { UpdateMoodDto } from './dto/update-mood.dto';
import { ApiBody, ApiOperation, ApiResponse, ApiTags } from '@nestjs/swagger';

@ApiTags('Mood Label Endpoints (For Music Mood Labels)')
@Controller('moods')
export class MoodsController {
  constructor(private readonly moodsService: MoodsService) {}

  @ApiOperation({ summary: 'Create a new mood label for music' })
  @ApiResponse({ status: 201, description: 'New mood created successfully' })
  @ApiResponse({
    status: 409,
    description: 'Mood with that name already exists',
  })
  @ApiBody({ type: CreateMoodDto })
  @Post()
  create(@Body() createMoodDto: CreateMoodDto) {
    return this.moodsService.create(createMoodDto);
  }

  @ApiOperation({
    summary: 'Return a list of all mood labels',
  })
  @ApiResponse({
    status: 200,
    description: 'List of moods',
  })
  @Get()
  findAll() {
    return this.moodsService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.moodsService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateMoodDto: UpdateMoodDto) {
    return this.moodsService.update(+id, updateMoodDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.moodsService.remove(+id);
  }
}
