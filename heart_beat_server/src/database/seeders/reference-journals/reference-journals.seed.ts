import { AppDataSource } from '../../../../data-source';
import { Mood } from '../../../entities/moods.entity';
import { ReferenceJournal } from '../../../entities/reference-journal.entity';
import { referenceEntries } from './reference-journals.data';

async function embedJournal(chunks: string[]): Promise<number[][]> {
  const modelUrl = process.env.HF_API_URL + process.env.HF_MODEL_ID!;
  const response = await fetch(modelUrl, {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${process.env.HF_API_KEY}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({ inputs: chunks }),
  });

  if (!response.ok) {
    const errText = await response.text();
    console.error('HF API error:', errText);
    throw new Error(errText);
  }

  const embeddings = (await response.json()) as number[][];
  return embeddings;
}

async function seedReferenceJournals() {
  await AppDataSource.initialize();

  const refJournalRepo = AppDataSource.getRepository(ReferenceJournal);
  const moodRepo = AppDataSource.getRepository(Mood);

  for (const [moodLabel, entries] of Object.entries(referenceEntries)) {
    const mood = await moodRepo.findOne({ where: { name: moodLabel } });
    if (!mood) continue;

    // Embed all entries for this mood at once
    const embeddings = await embedJournal(entries);

    for (let i = 0; i < entries.length; i++) {
      const refJournal = refJournalRepo.create({
        content: entries[i],
        embedding: JSON.stringify(embeddings[i]),
        moods: [mood],
      });

      await refJournalRepo.save(refJournal);
      console.log(`Inserted reference journal for mood: ${mood.name}`);
    }
  }

  console.log('✅ Reference journals seeded with embeddings successfully.');
  await AppDataSource.destroy();
}

seedReferenceJournals().catch((err) => console.error(err));
