import { Test, TestingModule } from '@nestjs/testing';
import { transactionTypes } from '../../../prisma/seed.constants';
import { prismaMock } from '../../../test/singleton';
import { DatabaseModule } from '../../database/database.module';
import { PrismaService } from '../../database/prisma/prisma.service';
import { TransactionsService } from '../../services/transactions/transactions.service';
import { TransactionsController } from './transactions.controller';

describe('TransactionsController', () => {
  let controller: TransactionsController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [DatabaseModule],
      controllers: [TransactionsController],
      providers: [TransactionsService],
    }).overrideProvider(PrismaService)
      .useValue(prismaMock)
      .compile();

    controller = module.get<TransactionsController>(TransactionsController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });

  it('should return an array of transactions types', async () => {
    prismaMock.transactionType.findMany.mockResolvedValue(transactionTypes)

    expect(await controller.getTransactionsTypes()).toBe(transactionTypes);
  });
});
