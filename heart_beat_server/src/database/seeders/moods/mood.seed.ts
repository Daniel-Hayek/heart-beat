import { AppDataSource } from '../../../../data-source';
import { Mood } from '../../../entities/moods.entity';

async function seedMoods() {
  await AppDataSource.initialize();
  const moodRepo = AppDataSource.getRepository(Mood);

  const moods = ['Happy', 'Sad', 'Calm', 'Focus', 'Energetic'].map((name) =>
    moodRepo.create({ name }),
  );

  for (const mood of moods) {
    await moodRepo.save(mood);
    console.log(`Inserted mood: ${mood.name}`);
  }

  console.log('Mood seeding complete!');
  await AppDataSource.destroy();
}

seedMoods().catch((err) => console.error(err));
