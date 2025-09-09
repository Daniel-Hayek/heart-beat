import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateReferenceMoodsTable1757426469728
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'reference_journal_moods',
        columns: [
          {
            name: 'reference_journal_id',
            type: 'int',
            isPrimary: true,
          },
          {
            name: 'mood_id',
            type: 'int',
            isPrimary: true,
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('reference_journal_moods');
  }
}
