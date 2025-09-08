import {
  ConflictException,
  Injectable,
  NotFoundException,
} from '@nestjs/common';
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
    return this.moodRepo.find();
  }

  async findOne(id: number) {
    const mood = await this.moodRepo.findOne({ where: { id } });
    if (mood == null) {
      throw new NotFoundException('No mood with that ID');
    }
    return mood;
  }

  async update(id: number, updateMoodDto: UpdateMoodDto) {
    const mood = await this.findOne(id);
    Object.assign(mood, updateMoodDto);
    return this.moodRepo.save(mood);
  }

  async remove(id: number) {
    const result = await this.moodRepo.delete(id);

    if (result.affected === 0) {
      throw new NotFoundException('No mood with that ID');
    }

    return 'Mood deleted successfully';
  }
}
