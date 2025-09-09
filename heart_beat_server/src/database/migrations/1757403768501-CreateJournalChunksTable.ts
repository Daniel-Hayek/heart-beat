import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateJournalChunksTable1757403768501
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'journal_chunks',
        columns: [
          {
            name: 'id',
            type: 'int',
            isPrimary: true,
            isGenerated: true,
            generationStrategy: 'increment',
          },
          {
            name: 'journal_id',
            type: 'int',
            isNullable: false,
          },
          {
            name: 'chunk_text',
            type: 'text',
            isNullable: false,
          },
          {
            name: 'embedding',
            type: 'vector',
            length: '1536',
            isNullable: true,
          },
          {
            name: 'created_at',
            type: 'timestamp',
            default: 'NOW()',
          },
          {
            name: 'updated_at',
            type: 'timestamp',
            default: 'NOW()',
          },
        ],
      }),
      true,
    );
  }
  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('journal_chunks');
  }
}
