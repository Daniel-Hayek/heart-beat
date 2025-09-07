import { Test, TestingModule } from '@nestjs/testing';
import { PlaylistSongController } from './playlist-song.controller';
import { PlaylistSongService } from './playlist-song.service';

describe('PlaylistSongController', () => {
  let controller: PlaylistSongController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [PlaylistSongController],
      providers: [PlaylistSongService],
    }).compile();

    controller = module.get<PlaylistSongController>(PlaylistSongController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
