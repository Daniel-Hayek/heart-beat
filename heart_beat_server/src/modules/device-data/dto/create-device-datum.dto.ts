import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsNumber, IsOptional } from 'class-validator';

export class CreateDeviceDatumDto {
  @ApiProperty({
    description: 'The ID of the user',
    example: 1,
  })
  @IsInt()
  userId: number;

  @ApiProperty({
    description: 'Sleep duration in hours the previous night',
    example: 7,
  })
  @IsNumber()
  sleep_duration: number;

  @ApiProperty({
    description: 'Heartrate in terms of BPM',
    example: 70,
  })
  @IsNumber()
  heartrate: number;

  @ApiProperty({
    description: 'Physical activity in minutes per day',
    example: 45,
  })
  @IsNumber()
  activity_level: number;

  @ApiProperty({
    description: 'Steps per day',
    example: 5000,
  })
  @IsNumber()
  steps: number;

  @ApiProperty({
    description: 'Phone usage in minutes',
    example: 230,
  })
  @IsOptional()
  @IsNumber()
  phone_usage: number | null;
}
