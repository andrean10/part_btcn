// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DataModel _$DataModelFromJson(Map<String, dynamic> json) {
  return _DataModel.fromJson(json);
}

/// @nodoc
mixin _$DataModel {
// List<PartModel>? parts,
  String get id => throw _privateConstructorUsedError;
  List<String> get partIds => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DataModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DataModelCopyWith<DataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataModelCopyWith<$Res> {
  factory $DataModelCopyWith(DataModel value, $Res Function(DataModel) then) =
      _$DataModelCopyWithImpl<$Res, DataModel>;
  @useResult
  $Res call(
      {String id,
      List<String> partIds,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? createdAt,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? updatedAt});
}

/// @nodoc
class _$DataModelCopyWithImpl<$Res, $Val extends DataModel>
    implements $DataModelCopyWith<$Res> {
  _$DataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partIds = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      partIds: null == partIds
          ? _value.partIds
          : partIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DataModelImplCopyWith<$Res>
    implements $DataModelCopyWith<$Res> {
  factory _$$DataModelImplCopyWith(
          _$DataModelImpl value, $Res Function(_$DataModelImpl) then) =
      __$$DataModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<String> partIds,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? createdAt,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? updatedAt});
}

/// @nodoc
class __$$DataModelImplCopyWithImpl<$Res>
    extends _$DataModelCopyWithImpl<$Res, _$DataModelImpl>
    implements _$$DataModelImplCopyWith<$Res> {
  __$$DataModelImplCopyWithImpl(
      _$DataModelImpl _value, $Res Function(_$DataModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DataModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? partIds = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$DataModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      partIds: null == partIds
          ? _value._partIds
          : partIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DataModelImpl implements _DataModel {
  const _$DataModelImpl(
      {required this.id,
      required final List<String> partIds,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      this.createdAt,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      this.updatedAt})
      : _partIds = partIds;

  factory _$DataModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DataModelImplFromJson(json);

// List<PartModel>? parts,
  @override
  final String id;
  final List<String> _partIds;
  @override
  List<String> get partIds {
    if (_partIds is EqualUnmodifiableListView) return _partIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_partIds);
  }

  @override
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  final DateTime? createdAt;
  @override
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'DataModel(id: $id, partIds: $partIds, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DataModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._partIds, _partIds) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id,
      const DeepCollectionEquality().hash(_partIds), createdAt, updatedAt);

  /// Create a copy of DataModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DataModelImplCopyWith<_$DataModelImpl> get copyWith =>
      __$$DataModelImplCopyWithImpl<_$DataModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DataModelImplToJson(
      this,
    );
  }
}

abstract class _DataModel implements DataModel {
  const factory _DataModel(
      {required final String id,
      required final List<String> partIds,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      final DateTime? createdAt,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      final DateTime? updatedAt}) = _$DataModelImpl;

  factory _DataModel.fromJson(Map<String, dynamic> json) =
      _$DataModelImpl.fromJson;

// List<PartModel>? parts,
  @override
  String get id;
  @override
  List<String> get partIds;
  @override
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  DateTime? get createdAt;
  @override
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  DateTime? get updatedAt;

  /// Create a copy of DataModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DataModelImplCopyWith<_$DataModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
