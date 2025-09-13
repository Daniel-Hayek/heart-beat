import { Controller, Get, Post, Body, Param } from '@nestjs/common';
import { DeviceDataService } from './device-data.service';
import { CreateDeviceDatumDto } from './dto/create-device-datum.dto';

@Controller('device-data')
export class DeviceDataController {
  constructor(private readonly deviceDataService: DeviceDataService) {}

  @Post()
  create(@Body() createDeviceDatumDto: CreateDeviceDatumDto) {
    return this.deviceDataService.create(createDeviceDatumDto);
  }

  @Get('/user/:id')
  findAll(@Param('id') userId: string) {
    return this.deviceDataService.findAll(+userId);
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.deviceDataService.findOne(+id);
  }
}
