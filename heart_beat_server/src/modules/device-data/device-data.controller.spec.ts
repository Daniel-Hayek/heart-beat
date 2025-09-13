import { Test, TestingModule } from '@nestjs/testing';
import { DeviceDataController } from './device-data.controller';
import { DeviceDataService } from './device-data.service';

describe('DeviceDataController', () => {
  let controller: DeviceDataController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [DeviceDataController],
      providers: [DeviceDataService],
    }).compile();

    controller = module.get<DeviceDataController>(DeviceDataController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
