import { Injectable } from '@nestjs/common';
import { CreateDeviceDatumDto } from './dto/create-device-datum.dto';
import { UpdateDeviceDatumDto } from './dto/update-device-datum.dto';

@Injectable()
export class DeviceDataService {
  create(createDeviceDatumDto: CreateDeviceDatumDto) {
    return 'This action adds a new deviceDatum';
  }

  findAll() {
    return `This action returns all deviceData`;
  }

  findOne(id: number) {
    return `This action returns a #${id} deviceDatum`;
  }
}
