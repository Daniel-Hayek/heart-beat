import { Module } from '@nestjs/common';
import { JournalsService } from './journals.service';
import { JournalsController } from './journals.controller';
import { Journal } from 'src/entities/journal.entity';
import { TypeOrmModule } from '@nestjs/typeorm';
import { User } from 'src/entities/user.entity';

@Module({
  imports: [TypeOrmModule.forFeature([Journal, User])],
  controllers: [JournalsController],
  providers: [JournalsService],
  exports: [JournalsService],
})
export class JournalsModule {}
