import { Injectable, NotFoundException } from '@nestjs/common';
import { CreateDeviceDatumDto } from './dto/create-device-datum.dto';
import { InjectRepository } from '@nestjs/typeorm';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';
import { DeviceDatum } from 'src/entities/device-datum.entity';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';

interface PredictionResponse {
  predicted_stress: number;
}

@Injectable()
export class DeviceDataService {
  constructor(
    @InjectRepository(DeviceDatum)
    private readonly dataRepo: Repository<DeviceDatum>,

    @InjectRepository(User)
    private readonly userRepo: Repository<User>,

    private readonly httpService: HttpService,
  ) {}

  async create(createDeviceDatumDto: CreateDeviceDatumDto) {
    const user = await this.userRepo.findOne({
      where: { id: createDeviceDatumDto.userId },
    });

    if (user == null) {
      throw new NotFoundException('No user with that ID');
    }

    const response = await firstValueFrom(
      this.httpService.post<PredictionResponse>(
        `${process.env.FAST_URL}:${process.env.FAST_PORT}/predict_stress`,
        {
          sleep_duration: Number(createDeviceDatumDto.sleep_duration),
          heart_rate: Number(createDeviceDatumDto.heartrate),
          daily_steps: Number(createDeviceDatumDto.steps),
          physical_activity_level: Number(createDeviceDatumDto.activity_level),
        },
      ),
    );

    const predStress = response.data['predicted_stress'];

    const deviceData = this.dataRepo.create({
      sleep_duration: createDeviceDatumDto.sleep_duration,
      heartrate: createDeviceDatumDto.heartrate,
      steps: createDeviceDatumDto.steps,
      activity_level: createDeviceDatumDto.activity_level,
      phone_usage: createDeviceDatumDto.phone_usage || 360,
      predicted_stress: predStress,
      user,
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
