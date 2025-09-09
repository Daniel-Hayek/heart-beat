import { Injectable } from '@nestjs/common';
import { CreateJournalDto } from './dto/create-journal.dto';

@Injectable()
export class JournalsChunks {
  static chunkJournal(createJournalDto: CreateJournalDto) {
    console.log('Hello from chunk journals');

    const content = createJournalDto.content;
    const chunk_length = 100;
    const chunks: string[] = [];

    for (let i = 0; i < content.length; i = i + chunk_length) {
      chunks.push(content.substring(i, i + chunk_length));
    }

    chunks.forEach((chunk) => console.log(chunk));
  }
}
