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
    // const embeddings: number[][] = [];
    const modelUrl = `https://api-inference.huggingface.co/models/sentence-transformers/all-MiniLM-L6-v2`;

    const response = await fetch(modelUrl, {
      method: 'POST',
      headers: {
        Authorization: `Bearer ${process.env.HF_API_KEY}`,
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ inputs: 'Sentence' }),
    });

    if (!response.ok) {
      const errText = await response.text();
      console.error('HF API error:', errText);
      throw new Error(errText);
    }

    const emb: number[][] = (await response.json()) as number[][];

    console.log(emb);
  }
}
