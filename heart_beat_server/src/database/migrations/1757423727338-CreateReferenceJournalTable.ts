import { MigrationInterface, QueryRunner } from 'typeorm';

export class CreateReferenceJournalTable1757423727338
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`CREATE EXTENSION IF NOT EXISTS vector`);

    await queryRunner.query(`
            CREATE TABLE "reference_journals" (
                "id" SERIAL PRIMARY KEY,
                "content" TEXT NOT NULL,
                "embedding" vector(384) NULL,
                "created_at" TIMESTAMP DEFAULT NOW(),
                "updated_at" TIMESTAMP DEFAULT NOW()
            )
        `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE "reference_journals"`);
  }
}
