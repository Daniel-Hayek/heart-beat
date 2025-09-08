import { AppDataSource } from '../../../../data-source';
import { Song } from '../../../entities/song.entity';
import { Mood } from '../../../entities/moods.entity';
import * as fs from 'fs';
import * as path from 'path';
import { In } from 'typeorm';

interface SongData {
  title: string;
  artist: string;
  duration?: number | null;
  song_url: string;
  moods: string[];
}

async function main() {
  await AppDataSource.initialize();
  const songRepo = AppDataSource.getRepository(Song);
  const moodRepo = AppDataSource.getRepository(Mood);

  const jsonPath = path.join(__dirname, 'song-data.json');
  const songsData = JSON.parse(
    fs.readFileSync(jsonPath, 'utf-8'),
  ) as SongData[];

  for (const data of songsData) {
    // Fetch Mood entities by name
    const moods = await moodRepo.findBy({
      name: In(data.moods),
    });

    const song = songRepo.create({
      title: data.title,
      artist: data.artist,
      duration: data.duration ?? null,
      song_url: data.song_url,
      moods: moods,
    });

    await songRepo.save(song);
    console.log(`Inserted: ${song.title} with moods: ${data.moods.join(', ')}`);
  }

  console.log('Song seeding complete!');
  await AppDataSource.destroy();
}

main().catch((err) => console.error(err));
