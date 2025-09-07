import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class AddScoreMoodTracking1757252572663 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumn(
      'mood_tracking',
      new TableColumn({
        name: 'score',
        type: 'int',
        isNullable: true,
        default: null,
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('mood_tracking', 'score');
  }
}
