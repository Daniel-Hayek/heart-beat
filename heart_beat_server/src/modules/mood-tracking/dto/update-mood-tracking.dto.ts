import { PartialType } from '@nestjs/swagger';
import { CreateMoodTrackingDto } from './create-mood-tracking.dto';

export class UpdateMoodTrackingDto extends PartialType(CreateMoodTrackingDto) {}
