import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class RemoveDescriptionPlaylistsTable1757226306570
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('playlists', 'description');
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumn(
      'playlists',
      new TableColumn({
        name: 'description',
        type: 'text',
        isNullable: true,
      }),
    );
  }
}
