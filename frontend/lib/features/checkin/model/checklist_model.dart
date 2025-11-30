import 'package:freezed_annotation/freezed_annotation.dart';

import 'checklist_photo_model.dart';

part 'checklist_model.freezed.dart';
part 'checklist_model.g.dart';

@freezed
class ChecklistModel with _$ChecklistModel {
  const factory ChecklistModel({
    int? id,
    @JsonKey(name: 'orcamentoId') required int orcamentoId,
    @JsonKey(name: 'dataCriacao') DateTime? dataCriacao,
    required String observacoes,
    required String tipo,
    @JsonKey(name: 'checklistItems')
    @Default(<ChecklistPhotoModel>[])
    List<ChecklistPhotoModel> checklistItems,
  }) = _ChecklistModel;

  factory ChecklistModel.fromJson(Map<String, dynamic> json) =>
      _$ChecklistModelFromJson(json);
}

