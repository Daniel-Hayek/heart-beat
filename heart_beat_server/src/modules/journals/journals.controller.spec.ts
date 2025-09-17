import { Test, TestingModule } from '@nestjs/testing';
import { JournalsController } from './journals.controller';
import { JournalsService } from './journals.service';
import { CreateJournalDto } from './dto/create-journal.dto';

describe('JournalsController', () => {
  let controller: JournalsController;
  let mockJournalsService: Partial<Record<keyof JournalsService, jest.Mock>>;

  beforeEach(async () => {
    mockJournalsService = {
      create: jest.fn().mockResolvedValue({}),
      findAll: jest.fn().mockResolvedValue([]),
      findJournalsByUserId: jest.fn().mockResolvedValue([]),
      remove: jest.fn().mockResolvedValue({}),
      getNumber: jest.fn().mockResolvedValue(0),
    };

    const module: TestingModule = await Test.createTestingModule({
      controllers: [JournalsController],
      providers: [
        {
          provide: JournalsService,
          useValue: mockJournalsService,
        },
      ],
    }).compile();

    controller = module.get<JournalsController>(JournalsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('create should call service.create', async () => {
    const dto: CreateJournalDto = { userId: 1, title: 'test', content: 'test' };
    await controller.create(dto);
    expect(mockJournalsService.create).toHaveBeenCalledWith(dto);
  });

  it('findAll should call service.findAll', async () => {
    await controller.findAll();
    expect(mockJournalsService.findAll).toHaveBeenCalled();
  });

  it('findOne should call service.findJournalsByUserId', async () => {
    const userId = '1';
    await controller.findOne(userId);
    expect(mockJournalsService.findJournalsByUserId).toHaveBeenCalledWith(1);
  });

  it('remove should call service.remove', async () => {
    const id = '1';
    await controller.remove(id);
    expect(mockJournalsService.remove).toHaveBeenCalledWith(1);
  });

  it('getNumber should call service.getNumber', async () => {
    const userId = '1';
    await controller.getNumber(userId);
    expect(mockJournalsService.getNumber).toHaveBeenCalledWith(1);
  });
});
