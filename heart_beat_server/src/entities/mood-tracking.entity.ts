import { IsInt, IsString, Max, Min } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { User } from './user.entity';

@Entity('mood_tracking')
export class MoodTracking {
  @PrimaryGeneratedColumn()
  id: number;

  @IsString()
  @Column()
  source: string;

  @IsString()
  @Column()
  mood: string;

  @IsInt()
  @Column()
  @Min(0)
  @Max(10)
  score: number;

  @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  timestamp: Date;

  @ManyToOne(() => User, (user) => user.moodTrackings, { onDelete: 'CASCADE' })
  user: User;
}
