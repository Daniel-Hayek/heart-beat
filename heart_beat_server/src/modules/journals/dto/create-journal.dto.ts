import { ApiProperty } from '@nestjs/swagger';
import { IsString } from 'class-validator';

export class CreateJournalDto {
  @ApiProperty({
    description: 'The ID of the user who wrote the entry',
    example: 20,
  })
  @IsString()
  userId: number;

  @ApiProperty({
    description: 'Title of the journal entry',
    example: 'My sad day',
  })
  @IsString()
  title: string;

  @ApiProperty({
    description: 'Content of the journal entry',
    example: 'Today I had a terrible day...',
  })
  @IsString()
  content: string;
}
