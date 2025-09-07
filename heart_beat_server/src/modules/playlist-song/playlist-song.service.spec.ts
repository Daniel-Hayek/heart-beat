import { Test, TestingModule } from '@nestjs/testing';
import { PlaylistSongService } from './playlist-song.service';

describe('PlaylistSongService', () => {
  let service: PlaylistSongService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [PlaylistSongService],
    }).compile();

    service = module.get<PlaylistSongService>(PlaylistSongService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
