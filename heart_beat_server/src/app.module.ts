import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from './modules/users/users.module';
import { JournalEntriesModule } from './modules/journal_entries/journal_entries.module';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: 'localhost',
      port: 5432,
      username: 'postgres',
      password: '12345',
      database: 'heartbeat_db',
      autoLoadEntities: true,
      synchronize: false,
    }),
    UsersModule,
    JournalEntriesModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
