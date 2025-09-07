import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { UsersModule } from './modules/users/users.module';
import { ConfigModule } from '@nestjs/config';
import { AuthModule } from './modules/auth/auth.module';
import { JournalsModule } from './modules/journals/journals.module';
import { SongsModule } from './modules/songs/songs.module';
import { PlaylistModule } from './modules/playlist/playlist.module';
import { PlaylistSongModule } from './modules/playlist-song/playlist-song.module';

@Module({
  imports: [
    ConfigModule.forRoot(),
    TypeOrmModule.forRoot({
      type: 'postgres',
      host: process.env.DB_HOST,
      port: parseInt(process.env.DB_PORT!),
      username: process.env.DB_USERNAME!,
      password: process.env.DB_PASSWORD!,
      database: process.env.DB_NAME!,
      autoLoadEntities: true,
      synchronize: false,
    }),
    AuthModule,
    UsersModule,
    JournalsModule,
    SongsModule,
    PlaylistModule,
    PlaylistSongModule,
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}
