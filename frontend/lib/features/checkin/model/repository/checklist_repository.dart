import 'dart:io';

import '../checklist_model.dart';
import 'package:image_picker/image_picker.dart';

abstract interface class ChecklistRepository {
  Future<ChecklistModel> createChecklist(
    int orcamentoId,
    String tipo,
    String observacoes,
    List<XFile> fotos,
  );

  Future<List<ChecklistModel>> findByOrcamentoId(int orcamentoId);

  String getChecklistPhotoUrl(String nomeFoto);
}

