import { PartialType } from '@nestjs/swagger';
import { CreateDeviceDatumDto } from './create-device-datum.dto';

export class UpdateDeviceDatumDto extends PartialType(CreateDeviceDatumDto) {}
