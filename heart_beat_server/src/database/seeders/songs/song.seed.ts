import { AppDataSource } from '../../../../data-source'; // adjust path
import { Song } from '../../../entities/song.entity'; // adjust path
import * as fs from 'fs';
import * as path from 'path';

interface SongData {
  title: string;
  artist: string;
  duration?: number | null;
  song_url: string;
  created_at: string;
}

async function main() {
  await AppDataSource.initialize();
  const songRepo = AppDataSource.getRepository(Song);

  const jsonPath = path.join(__dirname, 'song-data.json');
  const songsData = JSON.parse(
    fs.readFileSync(jsonPath, 'utf-8'),
  ) as SongData[];

  for (const data of songsData) {
    const song = songRepo.create({
      title: data.title,
      artist: data.artist,
      duration: data.duration ?? null,
      song_url: data.song_url,
    });

    await songRepo.save(song);
    console.log(`Inserted: ${song.title}`);
  }

  console.log('Seeding complete!');
  await AppDataSource.destroy();
}

main().catch((err) => console.error(err));
