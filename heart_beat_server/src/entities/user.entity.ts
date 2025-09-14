import { IsEmail, IsString, MinLength } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  Entity,
  OneToMany,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { Journal } from './journal.entity';
import { Playlist } from './playlist.entity';
import { MoodTracking } from './mood-tracking.entity';
import { DeviceDatum } from './device-datum.entity';

@Entity('users')
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @IsString()
  @Column()
  name: string;

  @IsEmail()
  @Column({ unique: true })
  email: string;

  @IsString()
  @MinLength(6)
  @Column()
  password: string;

  @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;

  @UpdateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;

  @OneToMany(() => Journal, (journal) => journal.user)
  journals: Journal[];

  @OneToMany(() => Playlist, (playlist) => playlist.user)
  playlists: Playlist[];

  @OneToMany(() => MoodTracking, (moodTracking) => moodTracking.user)
  moodTrackings: MoodTracking[];

  @OneToMany(() => DeviceDatum, (data) => data.user)
  deviceData: DeviceDatum[];
}
