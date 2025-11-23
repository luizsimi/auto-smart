import {
  Controller,
  Get,
  Post,
  Param,
  Body,
  BadRequestException,
  Query,
  UseGuards,
  Patch,
  NotFoundException,
} from '@nestjs/common';
import { OrcamentoService } from './orcamento.service';
import { Status, type Orcamento, type OrcamentoItem } from '@prisma/client';
import { plainToInstance } from 'class-transformer';
import { validate } from 'class-validator';
import {
  OrcamentoDto,
  OrcamentoItensArrayDto,
  UpdateOrcamentoItensDto,
} from './orcamento.dto';
import { JwtAuthGuard } from 'src/auth/guards/jwt-auth.guard';
import { UserService } from 'src/user/user.service';

@UseGuards(JwtAuthGuard)
@Controller('orcamentos')
export class OrcamentoController {
  constructor(
    private readonly orcamentoService: OrcamentoService,
    private readonly userService: UserService,
  ) {}

  @Post()
  async create(
    @Body()
    body,
  ): Promise<Orcamento & { orcamentoItems: OrcamentoItem[] }> {
    const { orcamentoItens, ...orcamento } = body;

    console.log(orcamentoItens, orcamento);

    const orcamentoInstance = plainToInstance(OrcamentoDto, orcamento);
    const orcamentoErrors = await validate(orcamentoInstance, {
      whitelist: true,
    });

    if (orcamentoErrors.length > 0) {
      throw new BadRequestException(orcamentoErrors);
    }

    const itensInstance = plainToInstance(OrcamentoItensArrayDto, {
      orcamentoItens: orcamentoItens as OrcamentoItem[],
    });

    const itensErrors = await validate(itensInstance);
    if (itensErrors.length > 0) {
      throw new BadRequestException(itensErrors);
    }

    return this.orcamentoService.create({
      orcamento: orcamento as Orcamento,
      orcamentoItens: orcamentoItens as OrcamentoItem[],
    });
  }

  @Get(':id')
  async findOne(@Param('id') id: number): Promise<Orcamento | null> {
    return this.orcamentoService.findOne(id);
  }

  @Get()
  async findAll(
    @Query('page') page = 1,
    @Query('limit') limit = 10,
  ): Promise<{
    data: Orcamento[];
    total: number;
    page: number;
    limit: number;
  }> {
    return this.orcamentoService.findAll(Number(page), Number(limit));
  }

  @Patch(':id/status')
  async updateStatus(@Param('id') id: number, @Body('status') status: Status) {
    if (status === undefined)
      throw new BadRequestException('status é obrigatório');

    try {
      return await this.orcamentoService.updateStatus(id, status);
    } catch (error: unknown) {
      throw new NotFoundException(
        (error as Error).message || 'Erro ao atualizar status',
      );
    }
  }

  @Patch(':id/itens')
  async updateItens(
    @Param('id') id: number,
    @Body() body: UpdateOrcamentoItensDto,
  ): Promise<OrcamentoItem[]> {
    if (!id) throw new BadRequestException('ID do orçamento é obrigatório');

    const { itens } = body;

    try {
      return await this.orcamentoService.updateItens(id, itens);
    } catch (error: unknown) {
      throw new BadRequestException(
        (error as Error).message || 'Erro ao atualizar itens',
      );
    }
  }
}
