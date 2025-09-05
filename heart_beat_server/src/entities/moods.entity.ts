import { IsString } from 'class-validator';
import { Column, Entity, PrimaryGeneratedColumn } from 'typeorm';

@Entity('moods')
export class Mood {
  @PrimaryGeneratedColumn()
  id: number;

  @IsString()
  @Column({ unique: true })
  name: string;
}
