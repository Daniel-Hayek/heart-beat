import { Module } from '@nestjs/common';
import { MoodsService } from './moods.service';
import { MoodsController } from './moods.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Mood } from 'src/entities/moods.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Mood])],
  controllers: [MoodsController],
  providers: [MoodsService],
})
export class MoodsModule {}
