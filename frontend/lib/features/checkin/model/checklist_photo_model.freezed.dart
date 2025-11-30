// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checklist_photo_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChecklistPhotoModel _$ChecklistPhotoModelFromJson(Map<String, dynamic> json) {
  return _ChecklistPhotoModel.fromJson(json);
}

/// @nodoc
mixin _$ChecklistPhotoModel {
  int? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'checklistId')
  int? get checklistId => throw _privateConstructorUsedError;
  @JsonKey(name: 'dataCriacao')
  DateTime? get dataCriacao => throw _privateConstructorUsedError;
  String get path => throw _privateConstructorUsedError;

  /// Serializes this ChecklistPhotoModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChecklistPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChecklistPhotoModelCopyWith<ChecklistPhotoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChecklistPhotoModelCopyWith<$Res> {
  factory $ChecklistPhotoModelCopyWith(
    ChecklistPhotoModel value,
    $Res Function(ChecklistPhotoModel) then,
  ) = _$ChecklistPhotoModelCopyWithImpl<$Res, ChecklistPhotoModel>;
  @useResult
  $Res call({
    int? id,
    @JsonKey(name: 'checklistId') int? checklistId,
    @JsonKey(name: 'dataCriacao') DateTime? dataCriacao,
    String path,
  });
}

/// @nodoc
class _$ChecklistPhotoModelCopyWithImpl<$Res, $Val extends ChecklistPhotoModel>
    implements $ChecklistPhotoModelCopyWith<$Res> {
  _$ChecklistPhotoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChecklistPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? checklistId = freezed,
    Object? dataCriacao = freezed,
    Object? path = null,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id                       as int?,
            checklistId: freezed == checklistId
                ? _value.checklistId
                : checklistId                       as int?,
            dataCriacao: freezed == dataCriacao
                ? _value.dataCriacao
                : dataCriacao                       as DateTime?,
            path: null == path
                ? _value.path
                : path                       as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChecklistPhotoModelImplCopyWith<$Res>
    implements $ChecklistPhotoModelCopyWith<$Res> {
  factory _$$ChecklistPhotoModelImplCopyWith(
    _$ChecklistPhotoModelImpl value,
    $Res Function(_$ChecklistPhotoModelImpl) then,
  ) = __$$ChecklistPhotoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int? id,
    @JsonKey(name: 'checklistId') int? checklistId,
    @JsonKey(name: 'dataCriacao') DateTime? dataCriacao,
    String path,
  });
}

/// @nodoc
class __$$ChecklistPhotoModelImplCopyWithImpl<$Res>
    extends _$ChecklistPhotoModelCopyWithImpl<$Res, _$ChecklistPhotoModelImpl>
    implements _$$ChecklistPhotoModelImplCopyWith<$Res> {
  __$$ChecklistPhotoModelImplCopyWithImpl(
    _$ChecklistPhotoModelImpl _value,
    $Res Function(_$ChecklistPhotoModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChecklistPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? checklistId = freezed,
    Object? dataCriacao = freezed,
    Object? path = null,
  }) {
    return _then(
      _$ChecklistPhotoModelImpl(
        id: freezed == id
            ? _value.id
            : id                   as int?,
        checklistId: freezed == checklistId
            ? _value.checklistId
            : checklistId                   as int?,
        dataCriacao: freezed == dataCriacao
            ? _value.dataCriacao
            : dataCriacao                   as DateTime?,
        path: null == path
            ? _value.path
            : path                   as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChecklistPhotoModelImpl implements _ChecklistPhotoModel {
  const _$ChecklistPhotoModelImpl({
    this.id,
    @JsonKey(name: 'checklistId') this.checklistId,
    @JsonKey(name: 'dataCriacao') this.dataCriacao,
    required this.path,
  });

  factory _$ChecklistPhotoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChecklistPhotoModelImplFromJson(json);

  @override
  final int? id;
  @override
  @JsonKey(name: 'checklistId')
  final int? checklistId;
  @override
  @JsonKey(name: 'dataCriacao')
  final DateTime? dataCriacao;
  @override
  final String path;

  @override
  String toString() {
    return 'ChecklistPhotoModel(id: $id, checklistId: $checklistId, dataCriacao: $dataCriacao, path: $path)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChecklistPhotoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.checklistId, checklistId) ||
                other.checklistId == checklistId) &&
            (identical(other.dataCriacao, dataCriacao) ||
                other.dataCriacao == dataCriacao) &&
            (identical(other.path, path) || other.path == path));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, checklistId, dataCriacao, path);

  /// Create a copy of ChecklistPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChecklistPhotoModelImplCopyWith<_$ChecklistPhotoModelImpl> get copyWith =>
      __$$ChecklistPhotoModelImplCopyWithImpl<_$ChecklistPhotoModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChecklistPhotoModelImplToJson(this);
  }
}

abstract class _ChecklistPhotoModel implements ChecklistPhotoModel {
  const factory _ChecklistPhotoModel({
    final int? id,
    @JsonKey(name: 'checklistId') final int? checklistId,
    @JsonKey(name: 'dataCriacao') final DateTime? dataCriacao,
    required final String path,
  }) = _$ChecklistPhotoModelImpl;

  factory _ChecklistPhotoModel.fromJson(Map<String, dynamic> json) =
      _$ChecklistPhotoModelImpl.fromJson;

  @override
  int? get id;
  @override
  @JsonKey(name: 'checklistId')
  int? get checklistId;
  @override
  @JsonKey(name: 'dataCriacao')
  DateTime? get dataCriacao;
  @override
  String get path;

  /// Create a copy of ChecklistPhotoModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChecklistPhotoModelImplCopyWith<_$ChecklistPhotoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
