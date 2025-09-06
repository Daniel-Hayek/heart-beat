import { IsOptional, IsString } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';
import { User } from './user.entity';

@Entity('journals')
export class Journal {
  @PrimaryGeneratedColumn()
  id: number;

  @IsOptional()
  @IsString()
  @Column()
  title: string;

  @IsString()
  @Column('text')
  content: string;

  @IsString()
  @Column({ type: 'varchar', nullable: true })
  mood_detected: string | null;

  @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;

  @UpdateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;

  @ManyToOne(() => User, (user) => user.journals, { onDelete: 'CASCADE' })
  user: User;
}
