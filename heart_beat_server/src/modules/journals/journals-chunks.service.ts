import { Injectable } from '@nestjs/common';
import { CreateJournalDto } from './dto/create-journal.dto';
import OpenAI from 'openai';

@Injectable()
export class JournalsChunks {
  static async chunkJournal(createJournalDto: CreateJournalDto) {
    console.log('Hello from chunk journals');

    const content = createJournalDto.content;
    const chunk_length = 100;
    const chunks: string[] = [];

    for (let i = 0; i < content.length; i = i + chunk_length) {
      chunks.push(content.substring(i, i + chunk_length));
    }

    await this.embedJournal(chunks);
  }

  static async embedJournal(chunks: Array<string>) {
    const embeddings: number[][] = [];

    const client = new OpenAI({ apiKey: process.env.OPENAI_KEY });

    for (const chunk of chunks) {
      const response = await client.embeddings.create({
        model: 'text-embedding-3-small',
        input: chunk,
      });

      embeddings.push(response.data[0].embedding);
    }

    console.log(embeddings[0]);
  }
}
