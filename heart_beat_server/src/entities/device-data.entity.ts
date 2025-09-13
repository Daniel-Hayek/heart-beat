import { IsNumber } from 'class-validator';
import {
  Column,
  CreateDateColumn,
  Entity,
  ManyToOne,
  PrimaryGeneratedColumn,
} from 'typeorm';
import { User } from './user.entity';

@Entity('device_data')
export class DeviceData {
  @PrimaryGeneratedColumn()
  id: number;

  @IsNumber()
  @Column({ type: 'real' })
  sleep_duration: number;

  @IsNumber()
  @Column({ type: 'real' })
  heartrate: number;

  @IsNumber()
  @Column({ type: 'real' })
  activity_level: number;

  @IsNumber()
  @Column({ type: 'real' })
  steps: number;

  @IsNumber()
  @Column({ type: 'real', nullable: true })
  phone_usage: number | null;

  @IsNumber()
  @Column()
  predicted_stress: number;

  @CreateDateColumn({ type: 'timestamp', default: () => 'CURRENT_TIMESTAMP' })
  created_at: Date;

  @ManyToOne(() => User, (user) => user.deviceData, { onDelete: 'CASCADE' })
  user: User;
}
