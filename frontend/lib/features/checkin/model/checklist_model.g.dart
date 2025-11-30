// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'checklist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChecklistModelImpl _$$ChecklistModelImplFromJson(Map<String, dynamic> json) =>
    _$ChecklistModelImpl(
      id: (json['id'] as num?)?.toInt(),
      orcamentoId: (json['orcamentoId'] as num).toInt(),
      dataCriacao: json['dataCriacao'] == null
          ? null
          : DateTime.parse(json['dataCriacao'] as String),
      observacoes: json['observacoes'] as String,
      tipo: json['tipo'] as String,
      checklistItems:
          (json['checklistItems'] as List<dynamic>?)
              ?.map(
                (e) => ChecklistPhotoModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const <ChecklistPhotoModel>[],
    );

Map<String, dynamic> _$$ChecklistModelImplToJson(
  _$ChecklistModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'orcamentoId': instance.orcamentoId,
  'dataCriacao': instance.dataCriacao?.toIso8601String(),
  'observacoes': instance.observacoes,
  'tipo': instance.tipo,
  'checklistItems': instance.checklistItems,
};
