// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_photo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChecklistPhotoModelImpl _$$ChecklistPhotoModelImplFromJson(
  Map<String, dynamic> json,
) => _$ChecklistPhotoModelImpl(
  id: (json['id'] as num?)?.toInt(),
  checklistId: (json['checklistId'] as num?)?.toInt(),
  dataCriacao: json['dataCriacao'] == null
      ? null
      : DateTime.parse(json['dataCriacao'] as String),
  path: json['path'] as String,
);

Map<String, dynamic> _$$ChecklistPhotoModelImplToJson(
  _$ChecklistPhotoModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'checklistId': instance.checklistId,
  'dataCriacao': instance.dataCriacao?.toIso8601String(),
  'path': instance.path,
};
