import { MigrationInterface, QueryRunner, Table } from 'typeorm';

export class CreateQuizQuestionsTable1756103538816
  implements MigrationInterface
{
  public async up(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.createTable(
      new Table({
        name: 'quiz_questions',
        columns: [
          {
            name: 'id',
            type: 'int',
            isPrimary: true,
            isGenerated: true,
            generationStrategy: 'increment',
          },
          {
            name: 'quiz_id',
            type: 'int',
          },
          {
            name: 'question_text',
            type: 'text',
          },
          {
            name: 'answer_type',
            type: 'varchar',
          },
        ],
      }),
      true,
    );
  }

  public async down(queryRunner: QueryRunner): Promise<void> {
    await queryRunner.dropTable('quiz_questions');
  }
}
