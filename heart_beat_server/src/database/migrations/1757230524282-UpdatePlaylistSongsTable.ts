import { MigrationInterface, QueryRunner } from 'typeorm';

export class UpdatePlaylistSongsTable1757230524282
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameColumn(
      'playlist_songs',
      'playlist_id',
      'playlistId',
    );
    await queryRunner.renameColumn('playlist_songs', 'song_id', 'songId');
    await queryRunner.renameColumn(
      'playlist_songs',
      'order_index',
      'orderIndex',
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameColumn(
      'playlist_songs',
      'playlistId',
      'playlist_id',
    );
    await queryRunner.renameColumn('playlist_songs', 'songId', 'song_id');
    await queryRunner.renameColumn(
      'playlist_songs',
      'orderIndex',
      'order_index',
    );
  }
}
