import { IsInt, IsString } from 'class-validator';
import { Column, Entity, ManyToMany, PrimaryGeneratedColumn } from 'typeorm';
import { Song } from './song.entity';
import { ReferenceJournal } from './reference-journal.entity';

@Entity('moods')
export class Mood {
  @PrimaryGeneratedColumn()
  id: number;

  @IsString()
  @Column({ unique: true })
  name: string;

  @IsInt()
  @Column()
  score: number;

  @ManyToMany(() => Song, (song) => song.moods)
  songs: Song[];

  @ManyToMany(
    () => ReferenceJournal,
    (referenceJournal) => referenceJournal.moods,
  )
  referenceJournals: ReferenceJournal[];
}
