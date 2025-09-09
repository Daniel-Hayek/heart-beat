import { Injectable } from '@nestjs/common';
import { CreateJournalDto } from './dto/create-journal.dto';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { JournalChunk } from 'src/entities/journal-chunk.entity';
import { CohereClient } from 'cohere-ai';

@Injectable()
export class JournalsChunks {
  constructor(
    @InjectRepository(User)
    private readonly userRepo: Repository<JournalChunk>,
  ) {}

  static async chunkJournal(createJournalDto: CreateJournalDto) {
    console.log('Hello from chunk journals');

    const content = createJournalDto.content;
    const chunk_length = 250;
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

    console.log(embeddings[0][0]);

    await this.analyzeEmbeddings(embeddings);
  }

  static async analyzeEmbeddings(embeddings: number[][]) {
    const cohere = new CohereClient({ token: process.env.CH_API_KEY! });

    const prompt = `You are a mood analysis assistant. 
    A journal entry has the following embedding vector: 
    ${JSON.stringify(embeddings)}
    
    Tell me how this person is feeling.
    `;

    const response = await cohere.generate({
      model: 'command-light',
      prompt: prompt,
      maxTokens: 100,
    });

    console.log(response.generations[0].text);
  }
}
