import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateSongMoodsTable1757067733704 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'song_moods',
        columns: [
          {
            name: 'song_id',
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
    await queryRunner.dropTable('song_moods');
  }
}
