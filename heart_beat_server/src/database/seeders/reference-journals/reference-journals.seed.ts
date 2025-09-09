import { AppDataSource } from '../../../../data-source';
import { Mood } from '../../../entities/moods.entity';
import { ReferenceJournal } from '../../../entities/reference-journal.entity';
import { referenceEntries } from './reference-journals.data';

async function seedReferenceJournals() {
  await AppDataSource.initialize();

  const refJournalRepo = AppDataSource.getRepository(ReferenceJournal);
  const moodRepo = AppDataSource.getRepository(Mood);

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
      console.log(`Inserted reference journal for mood: ${mood.name}`);
    }
  }

  console.log('✅ Reference journals seeded successfully.');
  await AppDataSource.destroy();
}

seedReferenceJournals().catch((err) => console.error(err));
