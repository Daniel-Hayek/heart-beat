import { AppDataSource } from '../../../../data-source';
import { Mood } from '../../../entities/moods.entity';

async function seedMoods() {
  await AppDataSource.initialize();
  const moodRepo = AppDataSource.getRepository(Mood);

  const moods = [
    { name: 'Happy', score: 10 },
    { name: 'Sad', score: 1 },
    { name: 'Calm', score: 6 },
    { name: 'Focus', score: 5 },
    { name: 'Energetic', score: 8 },
    { name: 'Angry', score: 3 },
    { name: 'Anxious', score: 4 },
    { name: 'Tired', score: 5 },
    { name: 'Lonely', score: 2 },
    { name: 'Excited', score: 9 },
    { name: 'Frustrated', score: 3 },
    { name: 'Hopeful', score: 7 },
  ].map((m) => moodRepo.create(m));

  for (const mood of moods) {
    await moodRepo.save(mood);
    console.log(`Inserted mood: ${mood.name}`);
  }

  console.log('Mood seeding complete!');
  await AppDataSource.destroy();
}

seedMoods().catch((err) => console.error(err));
