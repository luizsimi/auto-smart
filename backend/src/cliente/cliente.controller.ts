import {
  Controller,
  Get,
  Post,
  Put,
  Param,
  Body,
  UseGuards,
  BadRequestException,
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
    return this.clienteService.findOne(cpf);
  }

  @Put(':id')
  async update(
    @Param('id') id: string,
    @Body() data: Partial<{ nome: string; cpf: string; telefone: string }>,
  ): Promise<Cliente> {
    return this.clienteService.update(Number(id), data);
  }
}
