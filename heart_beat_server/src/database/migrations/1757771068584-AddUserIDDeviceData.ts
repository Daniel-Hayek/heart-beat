import { MigrationInterface, QueryRunner } from 'typeorm';

export class AddUserIDDeviceData1757771068584 implements MigrationInterface {
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameColumn('device_data', 'user_id', 'userId');
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.renameColumn('device_data', 'user_id', 'userId');
  }
}
