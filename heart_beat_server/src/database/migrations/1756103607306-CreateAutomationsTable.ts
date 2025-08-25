import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateAutomationsTable1756103607306 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'automations',
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
            name: 'type',
            type: 'varchar',
          },
          {
            name: 'frequency',
            type: 'varchar',
          },
          {
            name: 'enabled',
            type: 'boolean',
            default: true,
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('automations');
  }
}
