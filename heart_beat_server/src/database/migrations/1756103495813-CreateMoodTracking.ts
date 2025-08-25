import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateMoodTracking1756103495813 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'mood_tracking',
        columns: [
          {
            name: 'id',
            type: 'int',
            isPrimary: true,
            isGenerated: true,
            generationStrategy: 'increment',
          },
          {
            name: 'user_id',
            type: 'int',
          },
          {
            name: 'source',
            type: 'varchar',
          },
          {
            name: 'mood',
            type: 'varchar',
          },
          {
            name: 'timestamp',
            type: 'timestamp',
            default: 'now()',
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('mood_tracking');
  }
}
