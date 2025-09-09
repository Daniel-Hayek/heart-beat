import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateJournalMoodsTable1757426376101
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'journal_moods',
        columns: [
          {
            name: 'journal_id',
            type: 'int',
            isPrimary: true,
          },
          {
            name: 'mood_id',
            type: 'int',
            isPrimary: true,
          },
          {
            name: 'score',
            type: 'int',
            isNullable: true,
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('song_moods');
  }
}
