import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class UpdateSongsTable1757140294646 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('songs', 'album');
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumn(
      'songs',
      new TableColumn({ name: 'album', type: 'varchar', isNullable: true }),
    );
  }
}
