import { MigrationInterface, QueryRunner } from 'typeorm';

export class ChangeIDMoodTracking1757252799190 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameColumn('mood_tracking', 'user_id', 'userId');
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameColumn('mood_tracking', 'userId', 'user_id');
  }
}
