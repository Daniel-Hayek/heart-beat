import { PartialType } from '@nestjs/swagger';
import { CreateSongMoodDto } from './create-song-mood.dto';

export class UpdateSongMoodDto extends PartialType(CreateSongMoodDto) {}
