import { ConflictException, Injectable } from '@nestjs/common';
import { CreateMoodDto } from './dto/create-mood.dto';
import { UpdateMoodDto } from './dto/update-mood.dto';
import { Mood } from 'src/entities/moods.entity';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';

@Injectable()
export class MoodsService {
  constructor(
    @InjectRepository(Mood)
    private readonly moodRepo: Repository<Mood>,
  ) {}

  async create(createMoodDto: CreateMoodDto) {
    const exists = await this.moodRepo.findOne({
      where: { name: createMoodDto.name },
    });

    if (exists != null) {
      throw new ConflictException('That mood label already exists');
    }

    const mood = this.moodRepo.create({ name: createMoodDto.name });

    return this.moodRepo.save(mood);
  }

  findAll() {
    return `This action returns all moods`;
  }

  findOne(id: number) {
    return `This action returns a #${id} mood`;
  }

  update(id: number, updateMoodDto: UpdateMoodDto) {
    return `This action updates a #${id} mood`;
  }

  remove(id: number) {
    return `This action removes a #${id} mood`;
  }
}
