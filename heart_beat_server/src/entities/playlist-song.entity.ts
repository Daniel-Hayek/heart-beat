import { Column, Entity, ManyToOne, PrimaryGeneratedColumn } from 'typeorm';
import { Playlist } from './playlist.entity';
import { Song } from './song.entity';
import { IsInt } from 'class-validator';

@Entity('playlist_songs')
export class PlaylistSong {
  @PrimaryGeneratedColumn()
  id: number;

  @ManyToOne(() => Playlist, (playlist) => playlist.playlistSongs, {
    onDelete: 'CASCADE',
  })
  playlist: Playlist;

  @ManyToOne(() => Song, (song) => song.playlistSongs, {
    onDelete: 'CASCADE',
  })
  song: Song;

  @IsInt()
  @Column()
  orderIndex: number;
}
