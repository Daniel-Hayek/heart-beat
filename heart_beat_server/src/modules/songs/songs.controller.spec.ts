import { Test, TestingModule } from '@nestjs/testing';
import { SongsController } from './songs.controller';
import { SongsService } from './songs.service';
import { CreateSongDto } from './dto/create-song.dto';

describe('SongsController', () => {
  let controller: SongsController;
  let mockSongsService: Partial<Record<keyof SongsService, jest.Mock>>;

  beforeEach(async () => {
    mockSongsService = {
      create: jest.fn().mockResolvedValue({}),
      findAll: jest.fn().mockResolvedValue([]),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [SongsController],
      providers: [
        {
          provide: SongsService,
          useValue: mockSongsService,
        },
      ],
    }).compile();

    controller = module.get<SongsController>(SongsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('create should call service.create', async () => {
    const dto: CreateSongDto = {
      title: 'test',
      artist: 'test',
      duration: 0,
      song_url: 'test',
    };
    await controller.create(dto);
    expect(mockSongsService.create).toHaveBeenCalledWith(dto);
  });

  it('findAll should call service.findAll', async () => {
    await controller.findAll();
    expect(mockSongsService.findAll).toHaveBeenCalled();
  });
});
