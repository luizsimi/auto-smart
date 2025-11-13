import {
  Controller,
  Get,
  Post,
  Put,
  Param,
  Body,
  UseGuards,
  BadRequestException,
  NotFoundException,
} from '@nestjs/common';
import { ClienteService } from './cliente.service';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';
import { Cliente } from '@prisma/client';

@UseGuards(JwtAuthGuard) // protege todos os endpoints
@Controller('clientes')
export class ClienteController {
  constructor(private readonly clienteService: ClienteService) {}

  @Post()
  async create(
    @Body() data: { nome: string; cpf: string; telefone: string },
  ): Promise<Cliente | { message: string } | null> {
    const query = await this.clienteService.create(data);

    if (query.message) {
      throw new BadRequestException(query.message);
    }

    return query.data;
  }

  @Get(':cpf')
  async findOne(@Param('cpf') cpf: string): Promise<Cliente | null> {
    const result = await this.clienteService.findOne(cpf);
    if (!result) throw new NotFoundException();
    return result;
  }

  @Put(':id')
  async update(
    @Param('id') id: string,
    @Body() data: Partial<{ nome: string; cpf: string; telefone: string }>,
  ): Promise<Cliente> {
    return this.clienteService.update(Number(id), data);
  }
}
