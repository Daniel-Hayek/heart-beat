import { Module } from '@nestjs/common';
import { DeviceDataService } from './device-data.service';
import { DeviceDataController } from './device-data.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from 'src/entities/user.entity';
import { DeviceDatum } from 'src/entities/device-datum.entity';
import { HttpModule } from '@nestjs/axios';

@Module({
  imports: [TypeOrmModule.forFeature([User, DeviceDatum]), HttpModule],
  controllers: [DeviceDataController],
  providers: [DeviceDataService],
})
export class DeviceDataModule {}
