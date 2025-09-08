import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class DeleteMoodSongsTable1757322485271 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.query(`DROP TABLE IF EXISTS "song_moods"`);
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'song_moods',
        columns: [
          {
            name: 'songId',
            type: 'int',
            isPrimary: true,
          },
          {
            name: 'moodId',
            type: 'int',
            isPrimary: true,
          },
        ],
      }),
    );
  }
}
