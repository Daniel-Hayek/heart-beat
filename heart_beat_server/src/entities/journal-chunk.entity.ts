import { IsInt, IsString } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  Entity,
  PrimaryGeneratedColumn,
  UpdateDateColumn,
} from 'typeorm';

@Entity('journal_chunks')
export class JournalChunk {
  @PrimaryGeneratedColumn()
  id: number;

  @IsInt()
  @Column()
  journal_id: number;

  @IsString()
  @Column('text')
  chunk_text: string;

  @Column({ type: 'varchar', nullable: true })
  embedding: string;

  @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;

  @UpdateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  updated_at: Date;
}
