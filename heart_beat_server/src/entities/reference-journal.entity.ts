import {
  Entity,
  PrimaryGeneratedColumn,
  Column,
  ManyToMany,
  JoinTable,
} from 'typeorm';
import { Mood } from './moods.entity';

@Entity('reference_journals')
export class ReferenceJournal {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'text' })
  content: string;

  @Column({ type: 'varchar', nullable: true })
  embedding: string | null;

  @ManyToMany(() => Mood, (mood) => mood.referenceJournals)
  @JoinTable({
    name: 'reference_journal_moods',
    joinColumn: { name: 'reference_journal_id', referencedColumnName: 'id' },
    inverseJoinColumn: { name: 'mood_id', referencedColumnName: 'id' },
  })
  moods: Mood[];
}
