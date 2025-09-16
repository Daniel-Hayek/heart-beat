import { ApiProperty } from '@nestjs/swagger';
import { IsInt, IsNumber, IsString, Max, Min } from 'class-validator';

export class CreateMoodTrackingDto {
  @ApiProperty({
    description: 'The ID of the user who for whom this mood was tracked',
    example: 1,
  })
  @IsInt()
  userId: number;

  @ApiProperty({
    description: 'The source from which the mood was tracked',
    example: 'Journal',
  })
  @IsString()
  source: string;

  @ApiProperty({
    description: 'Words that describe the mood',
    example: 'Sad, Tired, Calm',
  })
  @IsString()
  mood: string;

  @ApiProperty({
    description:
      'A score between 0 and 10 which describes the mood (0 lowest - 10 highest)',
    example: '4',
  })
  @IsNumber()
  @Min(0)
  @Max(10)
  score: number;
}
