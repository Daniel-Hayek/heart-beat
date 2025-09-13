import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateSmartwatchDataTable1757767722257
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'device_data',
        columns: [
          {
            name: 'device_data_id',
            type: 'int',
            isPrimary: true,
          },
          {
            name: 'user_id',
            type: 'int',
          },
          {
            name: 'sleep_duration',
            type: 'real',
          },
          {
            name: 'heartrate',
            type: 'real',
          },
          {
            name: 'activity_level',
            type: 'real',
          },
          {
            name: 'steps',
            type: 'real',
          },
          {
            name: 'phone_usage',
            type: 'real',
            isNullable: true,
          },
          {
            name: 'predicted_stress',
            type: 'int',
            isNullable: true,
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('journal_chunks');
  }
}
