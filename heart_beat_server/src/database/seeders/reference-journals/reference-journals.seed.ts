import { DataSource } from 'typeorm';
import { Mood } from '../../../entities/moods.entity';
import { referenceEntries } from './reference-journals.data';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';
import { ReferenceJournalMood } from 'src/entities/reference-journal-mood.entity';

export const seedReferenceJournals = async (dataSource: DataSource) => {
  const refJournalRepo = dataSource.getRepository(ReferenceJournal);
  const refJournalMoodRepo = dataSource.getRepository(ReferenceJournalMood);
  const moodRepo = dataSource.getRepository(Mood);

  for (const [moodLabel, entries] of Object.entries(referenceEntries)) {
    const mood = await moodRepo.findOne({ where: { name: moodLabel } });
    if (!mood) continue;

    for (const entry of entries) {
      const refJournal = refJournalRepo.create({
        content: entry,
        embedding: null,
      });
      await refJournalRepo.save(refJournal);

      const pivot = refJournalMoodRepo.create({
        referenceJournal: refJournal,
        mood,
      });
      await refJournalMoodRepo.save(pivot);
    }
  }

  console.log('Reference journals seeded successfully.');
};
