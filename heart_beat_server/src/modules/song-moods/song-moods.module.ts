import { Module } from '@nestjs/common';
import { SongMoodsService } from './song-moods.service';
import { SongMoodsController } from './song-moods.controller';

@Module({
  controllers: [SongMoodsController],
  providers: [SongMoodsService],
})
export class SongMoodsModule {}
