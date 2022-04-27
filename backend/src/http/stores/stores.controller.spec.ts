import { Test, TestingModule } from '@nestjs/testing';
import { TransactionsService } from '../../services/transactions/transactions.service';
import { DatabaseModule } from '../../database/database.module';
import { StoresService } from '../../services/stores/stores.service';
import { StoresController } from './stores.controller';
import { PrismaService } from '../../database/prisma/prisma.service';
import { prismaMock } from '../../../test/singleton';

describe('StoresController', () => {
  let controller: StoresController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      imports: [DatabaseModule],
      controllers: [StoresController],
      providers: [StoresService, TransactionsService],
    }).overrideProvider(PrismaService)
      .useValue(prismaMock)
      .compile();

    controller = module.get<StoresController>(StoresController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
