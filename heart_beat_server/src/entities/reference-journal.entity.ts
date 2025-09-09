import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToMany,
  JoinTable,
} from 'typeorm';
import { Mood } from './moods.entity';

@Entity({ name: 'reference_journals' })
export class ReferenceJournal {
  @PrimaryGeneratedColumn()
  id: string;

  @Column({ type: 'text' })
  content: string;

  @Column({
    nullable: true,
  })
  embedding: number[];

  @ManyToMany(() => Mood, (mood) => mood.referenceJournals)
  @JoinTable({
    name: 'reference_journal_moods',
    joinColumn: { name: 'reference_journal_id', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'mood_id', referencedColumnName: 'id' },
  })
  moods: Mood[];
}
