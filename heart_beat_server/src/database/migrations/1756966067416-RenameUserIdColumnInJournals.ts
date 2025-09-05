import { MigrationInterface, QueryRunner } from 'typeorm';

export class RenameUserIdColumnInJournals1756966067416
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "journals" RENAME COLUMN "user_id" TO "userId"`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "journals" RENAME COLUMN "userId" TO "user_id"`,
    );
  }
}
