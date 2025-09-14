import { MigrationInterface, QueryRunner } from 'typeorm';

export class FixIDDeviceData1757771258259 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameColumn('device_data', 'device_data_id', 'id');
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameColumn('device_data', 'id', 'device_data_id');
  }
}
