import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdatePlaylistsTable1757225727607 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "playlists" RENAME COLUMN "user_id" TO "userId"`,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(
      `ALTER TABLE "playlists" RENAME COLUMN "userId" TO "user_id"`,
    );
  }
}
