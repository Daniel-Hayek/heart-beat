import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateDeviceDatumDto } from './dto/create-device-datum.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';
import { DeviceDatum } from 'src/entities/device-datum.entity';

@Injectable()
export class DeviceDataService {
  constructor(
    @InjectRepository(DeviceDatum)
    private readonly dataRepo: Repository<DeviceDatum>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,
  ) {}

  async create(createDeviceDatumDto: CreateDeviceDatumDto) {
    const user = await this.userRepo.findOne({
      where: { id: createDeviceDatumDto.userId },
    });

    if (user == null) {
      throw new NotFoundException('No user with that ID');
    }

    const deviceData = this.dataRepo.create({
      sleep_duration: createDeviceDatumDto.sleep_duration,
      heartrate: createDeviceDatumDto.heartrate,
      steps: createDeviceDatumDto.steps,
      activity_level: createDeviceDatumDto.activity_level,
      phone_usage: createDeviceDatumDto.phone_usage || 360,
    });

    return await this.dataRepo.save(deviceData);
  }

  async findAll(userId: number) {
    const data = await this.dataRepo.find({ where: { user: { id: userId } } });

    return data;
  }

  async findOne(id: number) {
    const datum = await this.dataRepo.findOne({ where: { id } });

    return datum;
  }
}
