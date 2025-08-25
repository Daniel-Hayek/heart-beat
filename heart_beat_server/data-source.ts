import { User } from 'src/entities/user.entity';
import { DataSource } from 'typeorm';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: 'localhost',
  port: 5432,
  username: 'postgres',
  password: '12345',
  database: 'heartbeat_db',
  entities: [User],
  migrations: ['src/database/migrations/*.ts'],
});
