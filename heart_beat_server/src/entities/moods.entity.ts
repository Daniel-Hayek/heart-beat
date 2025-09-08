import { IsString } from 'class-validator';
import { Column, Entity, ManyToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Song } from './song.entity';

@Entity('moods')
export class Mood {
  @PrimaryGeneratedColumn()
  id: number;

  @IsString()
  @Column({ unique: true })
  name: string;

  @ManyToMany(() => Song, (song) => song.moods)
  songs: Song[];
}
