import { Injectable } from '@nestjs/common';
import { User } from 'src/entities/user.entity';
import { Repository } from 'typeorm';
import { InjectRepository } from '@nestjs/typeorm';
import { JournalChunk } from 'src/entities/journal-chunk.entity';
import { Journal } from 'src/entities/journal.entity';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';
import cosineSimilarity from 'compute-cosine-similarity';

@Injectable()
export class JournalsChunks {
  constructor(
    @InjectRepository(JournalChunk)
    private readonly journalChunkRepo: Repository<JournalChunk>,

    @InjectRepository(ReferenceJournal)
    private readonly refJournalRepo: Repository<ReferenceJournal>,
  ) {}

  static chunkJournal(saved: Journal) {
    console.log('Hello from chunk journals');

    const content = saved.content;
    const chunk_length = 500;
    const chunks: string[] = [];

    for (let i = 0; i < content.length; i = i + chunk_length - 50) {
      chunks.push(content.substring(i, i + chunk_length));
    }

    return chunks;
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
    return embeddings;
  }

  static determineJournalMood(
    userEmbeddings: number[][],
    referenceJournals: ReferenceJournal[],
  ) {
    const moodScores: Record<string, number[]> = {};

    for (const chunkEmbedding of userEmbeddings) {
      for (const ref of referenceJournals) {
        const sim = cosineSimilarity(
          chunkEmbedding,
          JSON.parse(ref.embedding!),
        );

        for (const mood of ref.moods.map((m) => m.name)) {
          if (!moodScores[mood]) moodScores[mood] = [];
          moodScores[mood].push(sim!);
        }
      }
    }

    const averagedScores = Object.entries(moodScores).map(([mood, scores]) => ({
      mood,
      score: scores.reduce((a, b) => a + b, 0) / scores.length,
    }));

    // Sort descending
    return averagedScores.sort((a, b) => b.score - a.score);
  }
}
