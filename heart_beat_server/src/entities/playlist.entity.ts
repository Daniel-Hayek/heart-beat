import { IsBoolean, IsString } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { User } from './user.entity';
import { PlaylistSong } from './playlist-song.entity';

@Entity('playlists')
export class Playlist {
  @PrimaryGeneratedColumn()
  id: number;

  @IsString()
  @Column()
  name: string;

  @IsBoolean()
  @Column()
  is_auto_generated: boolean;

  @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;

  @UpdateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;

  @ManyToOne(() => User, (user) => user.playlists, { onDelete: 'CASCADE' })
  user: User;

  @OneToMany(() => PlaylistSong, (playlistSong) => playlistSong.playlist, {
    cascade: true,
  })
  playlistSongs: PlaylistSong[];
}
