import { Entity, PrimaryGeneratedColumn, ManyToOne, JoinColumn } from 'typeorm';
import { ReferenceJournal } from './reference-journal.entity';
import { Mood } from './moods.entity';

@Entity({ name: 'reference_journal_moods' })
export class ReferenceJournalMood {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => ReferenceJournal, (refJournal) => refJournal.moods, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'reference_journal_id' })
  referenceJournal: ReferenceJournal;

  @ManyToOne(() => Mood, (mood) => mood.referenceJournals, {
    onDelete: 'CASCADE',
  })
  @JoinColumn({ name: 'mood_id' })
  mood: Mood;
}
