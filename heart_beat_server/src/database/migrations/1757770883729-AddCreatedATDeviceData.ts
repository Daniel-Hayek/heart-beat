import { MigrationInterface, QueryRunner, TableColumn } from 'typeorm';

export class AddCreatedATDeviceData1757770883729 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.addColumn(
      'device_data',
      new TableColumn({
        name: 'created_at',
        type: 'timestamp',
        default: 'NOW()',
      }),
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropColumn('device_data', 'created_at');
  }
}
