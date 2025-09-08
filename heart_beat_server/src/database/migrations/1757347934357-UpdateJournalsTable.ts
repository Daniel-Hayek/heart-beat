import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdateJournalsTable1757347934357 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`
            ALTER TABLE "journals"
            ADD COLUMN "score_detected" INT
        `);
    await queryRunner.query(`
            ALTER TABLE "journals"
            ADD COLUMN "embedding" vector(1536)
        `);
    await queryRunner.query(`
            ALTER TABLE "journals"
            ADD COLUMN "processed" BOOLEAN DEFAULT FALSE
        `);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`ALTER TABLE "journals" DROP COLUMN "processed"`);
    await queryRunner.query(`ALTER TABLE "journals" DROP COLUMN "embedding"`);
    await queryRunner.query(
      `ALTER TABLE "journals" DROP COLUMN "score_detected"`,
    );
  }
}
