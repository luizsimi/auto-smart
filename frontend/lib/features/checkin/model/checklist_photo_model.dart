import 'package:freezed_annotation/freezed_annotation.dart';

part 'checklist_photo_model.freezed.dart';
part 'checklist_photo_model.g.dart';

@freezed
class ChecklistPhotoModel with _$ChecklistPhotoModel {
  const factory ChecklistPhotoModel({
    int? id,
    @JsonKey(name: 'checklistId') int? checklistId,
    @JsonKey(name: 'dataCriacao') DateTime? dataCriacao,
    required String path,
  }) = _ChecklistPhotoModel;

  factory ChecklistPhotoModel.fromJson(Map<String, dynamic> json) =>
      _$ChecklistPhotoModelFromJson(json);
}

