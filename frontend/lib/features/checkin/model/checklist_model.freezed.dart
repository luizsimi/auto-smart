// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checklist_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChecklistModel _$ChecklistModelFromJson(Map<String, dynamic> json) {
  return _ChecklistModel.fromJson(json);
}

/// @nodoc
mixin _$ChecklistModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'orcamentoId')
  int get orcamentoId => throw _privateConstructorUsedError;
  @JsonKey(name: 'dataCriacao')
  DateTime? get dataCriacao => throw _privateConstructorUsedError;
  String get observacoes => throw _privateConstructorUsedError;
  String get tipo => throw _privateConstructorUsedError;
  @JsonKey(name: 'checklistItems')
  List<ChecklistPhotoModel> get checklistItems =>
      throw _privateConstructorUsedError;

  /// Serializes this ChecklistModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChecklistModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChecklistModelCopyWith<ChecklistModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChecklistModelCopyWith<$Res> {
  factory $ChecklistModelCopyWith(
    ChecklistModel value,
    $Res Function(ChecklistModel) then,
  ) = _$ChecklistModelCopyWithImpl<$Res, ChecklistModel>;
  @useResult
  $Res call({
    int? id,
    @JsonKey(name: 'orcamentoId') int orcamentoId,
    @JsonKey(name: 'dataCriacao') DateTime? dataCriacao,
    String observacoes,
    String tipo,
    @JsonKey(name: 'checklistItems') List<ChecklistPhotoModel> checklistItems,
  });
}

/// @nodoc
class _$ChecklistModelCopyWithImpl<$Res, $Val extends ChecklistModel>
    implements $ChecklistModelCopyWith<$Res> {
  _$ChecklistModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChecklistModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orcamentoId = null,
    Object? dataCriacao = freezed,
    Object? observacoes = null,
    Object? tipo = null,
    Object? checklistItems = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id                       as int?,
            orcamentoId: null == orcamentoId
                ? _value.orcamentoId
                : orcamentoId                       as int,
            dataCriacao: freezed == dataCriacao
                ? _value.dataCriacao
                : dataCriacao                       as DateTime?,
            observacoes: null == observacoes
                ? _value.observacoes
                : observacoes                       as String,
            tipo: null == tipo
                ? _value.tipo
                : tipo                       as String,
            checklistItems: null == checklistItems
                ? _value.checklistItems
                : checklistItems                       as List<ChecklistPhotoModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChecklistModelImplCopyWith<$Res>
    implements $ChecklistModelCopyWith<$Res> {
  factory _$$ChecklistModelImplCopyWith(
    _$ChecklistModelImpl value,
    $Res Function(_$ChecklistModelImpl) then,
  ) = __$$ChecklistModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    @JsonKey(name: 'orcamentoId') int orcamentoId,
    @JsonKey(name: 'dataCriacao') DateTime? dataCriacao,
    String observacoes,
    String tipo,
    @JsonKey(name: 'checklistItems') List<ChecklistPhotoModel> checklistItems,
  });
}

/// @nodoc
class __$$ChecklistModelImplCopyWithImpl<$Res>
    extends _$ChecklistModelCopyWithImpl<$Res, _$ChecklistModelImpl>
    implements _$$ChecklistModelImplCopyWith<$Res> {
  __$$ChecklistModelImplCopyWithImpl(
    _$ChecklistModelImpl _value,
    $Res Function(_$ChecklistModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChecklistModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? orcamentoId = null,
    Object? dataCriacao = freezed,
    Object? observacoes = null,
    Object? tipo = null,
    Object? checklistItems = null,
  }) {
    return _then(
      _$ChecklistModelImpl(
        id: freezed == id
            ? _value.id
            : id                   as int?,
        orcamentoId: null == orcamentoId
            ? _value.orcamentoId
            : orcamentoId                   as int,
        dataCriacao: freezed == dataCriacao
            ? _value.dataCriacao
            : dataCriacao                   as DateTime?,
        observacoes: null == observacoes
            ? _value.observacoes
            : observacoes                   as String,
        tipo: null == tipo
            ? _value.tipo
            : tipo                   as String,
        checklistItems: null == checklistItems
            ? _value._checklistItems
            : checklistItems                   as List<ChecklistPhotoModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChecklistModelImpl implements _ChecklistModel {
  const _$ChecklistModelImpl({
    this.id,
    @JsonKey(name: 'orcamentoId') required this.orcamentoId,
    @JsonKey(name: 'dataCriacao') this.dataCriacao,
    required this.observacoes,
    required this.tipo,
    @JsonKey(name: 'checklistItems')
    final List<ChecklistPhotoModel> checklistItems =
        const <ChecklistPhotoModel>[],
  }) : _checklistItems = checklistItems;

  factory _$ChecklistModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChecklistModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'orcamentoId')
  final int orcamentoId;
  @override
  @JsonKey(name: 'dataCriacao')
  final DateTime? dataCriacao;
  @override
  final String observacoes;
  @override
  final String tipo;
  final List<ChecklistPhotoModel> _checklistItems;
  @override
  @JsonKey(name: 'checklistItems')
  List<ChecklistPhotoModel> get checklistItems {
    if (_checklistItems is EqualUnmodifiableListView) return _checklistItems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_checklistItems);
  }

  @override
  String toString() {
    return 'ChecklistModel(id: $id, orcamentoId: $orcamentoId, dataCriacao: $dataCriacao, observacoes: $observacoes, tipo: $tipo, checklistItems: $checklistItems)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChecklistModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.orcamentoId, orcamentoId) ||
                other.orcamentoId == orcamentoId) &&
            (identical(other.dataCriacao, dataCriacao) ||
                other.dataCriacao == dataCriacao) &&
            (identical(other.observacoes, observacoes) ||
                other.observacoes == observacoes) &&
            (identical(other.tipo, tipo) || other.tipo == tipo) &&
            const DeepCollectionEquality().equals(
              other._checklistItems,
              _checklistItems,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    orcamentoId,
    dataCriacao,
    observacoes,
    tipo,
    const DeepCollectionEquality().hash(_checklistItems),
  );

  /// Create a copy of ChecklistModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChecklistModelImplCopyWith<_$ChecklistModelImpl> get copyWith =>
      __$$ChecklistModelImplCopyWithImpl<_$ChecklistModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChecklistModelImplToJson(this);
  }
}

abstract class _ChecklistModel implements ChecklistModel {
  const factory _ChecklistModel({
    final int? id,
    @JsonKey(name: 'orcamentoId') required final int orcamentoId,
    @JsonKey(name: 'dataCriacao') final DateTime? dataCriacao,
    required final String observacoes,
    required final String tipo,
    @JsonKey(name: 'checklistItems')
    final List<ChecklistPhotoModel> checklistItems,
  }) = _$ChecklistModelImpl;

  factory _ChecklistModel.fromJson(Map<String, dynamic> json) =
      _$ChecklistModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'orcamentoId')
  int get orcamentoId;
  @override
  @JsonKey(name: 'dataCriacao')
  DateTime? get dataCriacao;
  @override
  String get observacoes;
  @override
  String get tipo;
  @override
  @JsonKey(name: 'checklistItems')
  List<ChecklistPhotoModel> get checklistItems;

  /// Create a copy of ChecklistModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChecklistModelImplCopyWith<_$ChecklistModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
