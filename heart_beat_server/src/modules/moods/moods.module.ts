import { Module } from '@nestjs/common';
import { MoodsService } from './moods.service';
import { MoodsController } from './moods.controller';
import { TypeOrmModule } from '@nestjs/typeorm';
import { Mood } from 'src/entities/moods.entity';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Mood, ReferenceJournal])],
  controllers: [MoodsController],
  providers: [MoodsService],
})
export class MoodsModule {}
