import { IsInt, IsString } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  Entity,
  JoinTable,
  ManyToMany,
  OneToMany,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { PlaylistSong } from './playlist-song.entity';
import { Mood } from './moods.entity';

@Entity('songs')
export class Song {
  @PrimaryGeneratedColumn()
  id: number;

  @IsString()
  @Column()
  title: string;

  @IsString()
  @Column()
  artist: string;

  @IsInt()
  @Column({ type: 'varchar', nullable: true })
  duration: number | null;

  @IsString()
  @Column()
  song_url: string;

  @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;

  @OneToMany(() => PlaylistSong, (playlistSong) => playlistSong.song)
  playlistSongs: PlaylistSong[];

  @ManyToMany(() => Mood, (mood) => mood.songs)
  @JoinTable()
  moods: Mood[];
}
