import {
  Controller,
  Get,
  Post,
  Body,
  UseInterceptors,
  UploadedFiles,
  Req,
  UseGuards,
  UnauthorizedException,
  Param,
  Res,
} from '@nestjs/common';
import { ChecklistService } from './checklist.service';
import { AnyFilesInterceptor } from '@nestjs/platform-express';
import { CreateChecklistDto } from './dto/create-checklist.dto';
import { AuthGuard } from '@nestjs/passport';
import type { Request } from 'express';
import { multerConfig } from 'src/upload/multer.config';
import { join } from 'path';
import type { Response } from 'express';
import { promises as fs } from 'fs';

@UseGuards(AuthGuard('jwt'))
@Controller('checklist')
export class ChecklistController {
  constructor(private readonly checklistService: ChecklistService) {}

  @Post()
  @UseInterceptors(AnyFilesInterceptor(multerConfig))
  async upload(
    @UploadedFiles() files: Express.Multer.File[],
    @Body() body: CreateChecklistDto,
    @Req() req: Request,
  ) {
    const { cpf } = req.user as { cpf: string };

    if (!cpf) throw new UnauthorizedException('Usuário não autenticado');

    const result = await this.checklistService.createChecklist(
      body,
      files,
      cpf,
    );

    return result;
  }

  @Get('orcamento/:orcamentoId')
  async findByOrcamentoId(@Param('orcamentoId') orcamentoId: string) {
    return await this.checklistService.findByOrcamentoId(Number(orcamentoId));
  }

  @Get(':id')
  async findChekList(@Param('id') id: string) {
    return await this.checklistService.findChekList(Number(id));
  }

  @Get(':nome/foto')
  async getFoto(@Param('nome') nome: string, @Res() res: Response) {
    const filePath = join(__dirname, '../../uploads/fotos', nome);
    try {
      await fs.access(filePath);
      res.sendFile(filePath);
    } catch (err: unknown) {
      res.status(404).json({ message: 'Arquivo não encontrado', error: err });
    }
  }
}
