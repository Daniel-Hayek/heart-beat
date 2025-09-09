import { Injectable } from '@nestjs/common';
import { CreateJournalDto } from './dto/create-journal.dto';

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
    const modelUrl = process.env.HF_API_URL + process.env.HF_MODEL_ID!;

    const response = await fetch(modelUrl, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${process.env.HF_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ inputs: chunks }),
    });

    if (!response.ok) {
      const errText = await response.text();
      console.error('HF API error:', errText);
      throw new Error(errText);
    }

    const embeddings = (await response.json()) as number[][];

    console.log(embeddings);
  }
}
