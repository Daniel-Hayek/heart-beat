import { Module } from '@nestjs/common';
import { SongMoodsService } from './song-moods.service';
import { SongMoodsController } from './song-moods.controller';
import { Song } from 'src/entities/song.entity';
import { Mood } from 'src/entities/moods.entity';
import { TypeOrmModule } from '@nestjs/typeorm';

@Module({
  imports: [TypeOrmModule.forFeature([Song, Mood])],
  controllers: [SongMoodsController],
  providers: [SongMoodsService],
})
export class SongMoodsModule {}
