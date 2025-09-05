import { Column, Entity, PrimaryGeneratedColumn, Unique } from 'typeorm';

@Entity('song_moods')
@Unique(['songId', 'moodId'])
export class SongMood {
  @PrimaryGeneratedColumn()
  id: number;

  @Column()
  songId: number;

  @Column()
  moodId: number;
}
