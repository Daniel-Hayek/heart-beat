import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { DeviceDataService } from './device-data.service';
import { CreateDeviceDatumDto } from './dto/create-device-datum.dto';
import { ApiBody, ApiOperation, ApiResponse } from '@nestjs/swagger';

@Controller('device-data')
export class DeviceDataController {
  constructor(private readonly deviceDataService: DeviceDataService) {}

  @ApiOperation({ summary: 'Create a new data entry for a user' })
  @ApiResponse({ status: 201, description: 'Data logged' })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @ApiResponse({ status: 404, description: 'No user with that ID' })
  @ApiBody({ type: CreateDeviceDatumDto })
  @Post()
  create(@Body() createDeviceDatumDto: CreateDeviceDatumDto) {
    return this.deviceDataService.create(createDeviceDatumDto);
  }

  @ApiOperation({
    summary: 'Return a list of all data belonging to a user',
  })
  @ApiResponse({
    status: 200,
    description: 'List of journals',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @Get('/user/:id')
  findAll(@Param('id') userId: string) {
    return this.deviceDataService.findAll(+userId);
  }

  @ApiOperation({
    summary: 'Return a specific data entry',
  })
  @ApiResponse({
    status: 200,
    description: 'Data entry',
  })
  @ApiResponse({
    status: 401,
    description: 'Unauthorized',
  })
  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.deviceDataService.findOne(+id);
  }
}
