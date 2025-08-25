import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreatePlaylistSongsTable1756103591343
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'playlist_songs',
        columns: [
          {
            name: 'playlist_id',
            type: 'int',
          },
          {
            name: 'song_id',
            type: 'int',
          },
          {
            name: 'order_index',
            type: 'int',
            isNullable: true,
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('playlist_songs');
  }
}
