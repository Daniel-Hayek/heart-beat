import { DataSource } from 'typeorm';
import 'dotenv/config';
import { User } from './src/entities/user.entity';
import { Journal } from './src/entities/journal.entity';
import { Song } from './src/entities/song.entity';
import { Playlist } from './src/entities/playlist.entity';
import { PlaylistSong } from './src/entities/playlist-song.entity';
import { MoodTracking } from './src/entities/mood-tracking.entity';
import { JournalChunk } from './src/entities/journal-chunk.entity';
import { Mood } from './src/entities/moods.entity';
import { ReferenceJournal } from './src/entities/reference-journal.entity';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: process.env.DB_HOST,
  port: parseInt(process.env.DB_PORT!),
  username: process.env.DB_USERNAME!,
  password: String(process.env.DB_PASSWORD!),
  database: process.env.DB_NAME!,
  entities: [
    User,
    Journal,
    Song,
    Playlist,
    PlaylistSong,
    MoodTracking,
    JournalChunk,
    Mood,
    ReferenceJournal,
  ],
  migrations: ['src/database/migrations/*.ts'],
});
