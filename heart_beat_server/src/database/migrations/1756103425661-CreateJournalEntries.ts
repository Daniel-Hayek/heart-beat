import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateJournalEntries1756103425661 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'journal_entries',
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
            name: 'title',
            type: 'varchar',
            isNullable: true,
          },
          {
            name: 'content',
            type: 'text',
          },
          {
            name: 'mood_detected',
            type: 'varchar',
            isNullable: true,
          },
          {
            name: 'created_at',
            type: 'timestamp',
            default: 'now()',
          },
          {
            name: 'updated_at',
            type: 'timestamp',
            default: 'now()',
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('journal_entries');
  }
}
