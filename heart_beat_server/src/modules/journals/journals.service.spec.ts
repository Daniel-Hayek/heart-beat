import { Test, TestingModule } from '@nestjs/testing';
import { JournalsService } from './journals.service';
import { Repository } from 'typeorm';
import { Journal } from 'src/entities/journal.entity';
import { User } from 'src/entities/user.entity';
import { getRepositoryToken } from '@nestjs/typeorm';
import { NotFoundException } from '@nestjs/common';
import { CreateJournalDto } from './dto/create-journal.dto';
import { ReferenceJournal } from 'src/entities/reference-journal.entity';

describe('JournalsService', () => {
  let service: JournalsService;
  let journalRepo: Partial<Repository<Journal>>;
  let userRepo: Partial<Repository<User>>;

  beforeEach(async () => {
    journalRepo = {
      create: jest.fn(),
      save: jest.fn(),
      find: jest.fn(),
      findOne: jest.fn(),
      delete: jest.fn(),
      count: jest.fn(),
    };

    userRepo = {
      findOne: jest.fn(),
    };

    const refJournalRepo = {
      find: jest.fn(),
      findOne: jest.fn(),
      save: jest.fn(),
    };

    const mockQueue = {
      add: jest.fn(),
    };

    const module: TestingModule = await Test.createTestingModule({
      providers: [
        JournalsService,
        { provide: getRepositoryToken(Journal), useValue: journalRepo },
        { provide: getRepositoryToken(User), useValue: userRepo },
        {
          provide: getRepositoryToken(ReferenceJournal),
          useValue: refJournalRepo,
        },
        { provide: 'BullQueue_journal-processing', useValue: mockQueue },
      ],
    }).compile();

    service = module.get<JournalsService>(JournalsService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });

  describe('create', () => {
    it('should create and save a journal if user exists', async () => {
      const dto: CreateJournalDto = {
        title: 'Test',
        content: 'Content',
        userId: 1,
      };
      const mockUser = { id: 1 } as User;
      const mockJournal: Journal = {
        id: 1,
        user: mockUser,
        title: dto.title,
        content: dto.content,
        moods_assigned: 'null',
        created_at: new Date(),
        updated_at: new Date(),
      } as Journal;

      (userRepo.findOne as jest.Mock).mockResolvedValue(mockUser);
      (journalRepo.create as jest.Mock).mockReturnValue(mockJournal);
      (journalRepo.save as jest.Mock).mockResolvedValue(mockJournal);

      const result = await service.create(dto);
      expect(result).toEqual(mockJournal);
      expect(userRepo.findOne).toHaveBeenCalledWith({
        where: { id: dto.userId },
      });
      expect(journalRepo.create).toHaveBeenCalledWith({
        title: dto.title,
        content: dto.content,
        user: mockUser,
      });

      expect(journalRepo.save).toHaveBeenCalledWith(mockJournal);
    });

    it('should throw NotFoundException if user does not exist', async () => {
      (userRepo.findOne as jest.Mock).mockResolvedValue(null);
      await expect(
        service.create({ title: '', content: '', userId: 999 }),
      ).rejects.toThrow(NotFoundException);
    });
  });

  describe('findAll', () => {
    it('should return all journals', async () => {
      const mockJournals = [{ id: 1 }, { id: 2 }] as Journal[];
      (journalRepo.find as jest.Mock).mockResolvedValue(mockJournals);

      const result = await service.findAll();
      expect(result).toEqual(mockJournals);
    });
  });

  describe('findJournalsByUserId', () => {
    it('should return journals if user exists', async () => {
      const mockUser = { id: 1 } as User;
      const mockJournals = [{ id: 1 }] as Journal[];

      (userRepo.findOne as jest.Mock).mockResolvedValue(mockUser);
      (journalRepo.find as jest.Mock).mockResolvedValue(mockJournals);

      const result = await service.findJournalsByUserId(1);
      expect(result).toEqual(mockJournals);
    });

    it('should throw NotFoundException if user does not exist', async () => {
      (userRepo.findOne as jest.Mock).mockResolvedValue(null);
      await expect(service.findJournalsByUserId(999)).rejects.toThrow(
        NotFoundException,
      );
    });
  });

  describe('remove', () => {
    it('should delete a journal if it exists', async () => {
      (journalRepo.delete as jest.Mock).mockResolvedValue({ affected: 1 });
      const result = await service.remove(1);
      expect(result).toEqual('Journal 1 deleted');
    });

    it('should throw NotFoundException if journal does not exist', async () => {
      (journalRepo.delete as jest.Mock).mockResolvedValue({ affected: 0 });
      await expect(service.remove(999)).rejects.toThrow(NotFoundException);
    });
  });

  describe('getNumber', () => {
    it('should return the number of journals', async () => {
      (journalRepo.find as jest.Mock).mockResolvedValue([{}]);
      (journalRepo.count as jest.Mock).mockResolvedValue(5);

      const result = await service.getNumber(1);
      expect(result).toEqual(5);
    });

    it('should throw NotFoundException if user not found', async () => {
      (journalRepo.find as jest.Mock).mockResolvedValue(null);
      await expect(service.getNumber(999)).rejects.toThrow(NotFoundException);
    });
  });
});
