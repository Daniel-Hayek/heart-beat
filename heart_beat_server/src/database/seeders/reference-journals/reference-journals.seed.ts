import { DataSource } from 'typeorm';
import { Mood } from '../../../entities/moods.entity';
import { ReferenceJournal } from '../../../entities/reference-journal.entity';
import { referenceEntries } from './reference-journals.data';

export const seedReferenceJournals = async (dataSource: DataSource) => {
  const refJournalRepo = dataSource.getRepository(ReferenceJournal);
  const moodRepo = dataSource.getRepository(Mood);

  for (const [moodLabel, entries] of Object.entries(referenceEntries)) {
    const mood = await moodRepo.findOne({ where: { name: moodLabel } });
    if (!mood) continue;

    for (const entry of entries) {
      const refJournal = refJournalRepo.create({
        content: entry,
        embedding: null,
        moods: [mood],
      });

      await refJournalRepo.save(refJournal);
    }
  }

  console.log('✅ Reference journals seeded successfully.');
};
