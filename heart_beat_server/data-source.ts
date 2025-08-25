import { DataSource } from 'typeorm';
import { User } from './src/models/users/entities/user.entity';

export const AppDataSource = new DataSource({
  type: 'postgres',
  host: 'localhost',
  port: 5432,
  username: 'postgres',
  password: '12345',
  database: 'heartbeat_db',
  entities: [User],
  migrations: ['src/migrations/*.ts'],
});
