import { MigrationInterface, QueryRunner } from 'typeorm';

export class RenameJournalEntriesTableToJournals1756916647004
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameTable('journal_entries', 'journals');
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameTable('journals', 'journal_entries');
  }
}
