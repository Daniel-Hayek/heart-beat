import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class AddIDPlaylistSongsTable1757232951428
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumn(
      'playlist_songs',
      new TableColumn({
        name: 'id',
        type: 'int',
        isPrimary: true,
        isGenerated: true,
        generationStrategy: 'increment',
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('playlist_songs', 'id');
  }
}
