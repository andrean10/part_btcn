// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'part_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

PartModel _$PartModelFromJson(Map<String, dynamic> json) {
  return _PartModel.fromJson(json);
}

/// @nodoc
mixin _$PartModel {
  String get description => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  DateTime? get createdAt => throw _privateConstructorUsedError; // @JsonKey(
//   fromJson: FormatDateTime.timestampFromJson,
//   toJson: FormatDateTime.timestampToJson,
// )
// DateTime? updatedAt,
  num get price => throw _privateConstructorUsedError;
  num get quantity => throw _privateConstructorUsedError;
  num get totalPrice => throw _privateConstructorUsedError;
  String get id => throw _privateConstructorUsedError;
  List<String> get modelIds => throw _privateConstructorUsedError;

  /// Serializes this PartModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartModelCopyWith<PartModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartModelCopyWith<$Res> {
  factory $PartModelCopyWith(PartModel value, $Res Function(PartModel) then) =
      _$PartModelCopyWithImpl<$Res, PartModel>;
  @useResult
  $Res call(
      {String description,
      List<String>? images,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? createdAt,
      num price,
      num quantity,
      num totalPrice,
      String id,
      List<String> modelIds});
}

/// @nodoc
class _$PartModelCopyWithImpl<$Res, $Val extends PartModel>
    implements $PartModelCopyWith<$Res> {
  _$PartModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? images = freezed,
    Object? createdAt = freezed,
    Object? price = null,
    Object? quantity = null,
    Object? totalPrice = null,
    Object? id = null,
    Object? modelIds = null,
  }) {
    return _then(_value.copyWith(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as num,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      modelIds: null == modelIds
          ? _value.modelIds
          : modelIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartModelImplCopyWith<$Res>
    implements $PartModelCopyWith<$Res> {
  factory _$$PartModelImplCopyWith(
          _$PartModelImpl value, $Res Function(_$PartModelImpl) then) =
      __$$PartModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String description,
      List<String>? images,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? createdAt,
      num price,
      num quantity,
      num totalPrice,
      String id,
      List<String> modelIds});
}

/// @nodoc
class __$$PartModelImplCopyWithImpl<$Res>
    extends _$PartModelCopyWithImpl<$Res, _$PartModelImpl>
    implements _$$PartModelImplCopyWith<$Res> {
  __$$PartModelImplCopyWithImpl(
      _$PartModelImpl _value, $Res Function(_$PartModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? description = null,
    Object? images = freezed,
    Object? createdAt = freezed,
    Object? price = null,
    Object? quantity = null,
    Object? totalPrice = null,
    Object? id = null,
    Object? modelIds = null,
  }) {
    return _then(_$PartModelImpl(
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as num,
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      modelIds: null == modelIds
          ? _value._modelIds
          : modelIds // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartModelImpl implements _PartModel {
  const _$PartModelImpl(
      {this.description = '-',
      final List<String>? images,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      this.createdAt,
      this.price = 0,
      this.quantity = 0,
      this.totalPrice = 0,
      required this.id,
      required final List<String> modelIds})
      : _images = images,
        _modelIds = modelIds;

  factory _$PartModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartModelImplFromJson(json);

  @override
  @JsonKey()
  final String description;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  final DateTime? createdAt;
// @JsonKey(
//   fromJson: FormatDateTime.timestampFromJson,
//   toJson: FormatDateTime.timestampToJson,
// )
// DateTime? updatedAt,
  @override
  @JsonKey()
  final num price;
  @override
  @JsonKey()
  final num quantity;
  @override
  @JsonKey()
  final num totalPrice;
  @override
  final String id;
  final List<String> _modelIds;
  @override
  List<String> get modelIds {
    if (_modelIds is EqualUnmodifiableListView) return _modelIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_modelIds);
  }

  @override
  String toString() {
    return 'PartModel(description: $description, images: $images, createdAt: $createdAt, price: $price, quantity: $quantity, totalPrice: $totalPrice, id: $id, modelIds: $modelIds)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartModelImpl &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._images, _images) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._modelIds, _modelIds));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      description,
      const DeepCollectionEquality().hash(_images),
      createdAt,
      price,
      quantity,
      totalPrice,
      id,
      const DeepCollectionEquality().hash(_modelIds));

  /// Create a copy of PartModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartModelImplCopyWith<_$PartModelImpl> get copyWith =>
      __$$PartModelImplCopyWithImpl<_$PartModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartModelImplToJson(
      this,
    );
  }
}

abstract class _PartModel implements PartModel {
  const factory _PartModel(
      {final String description,
      final List<String>? images,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      final DateTime? createdAt,
      final num price,
      final num quantity,
      final num totalPrice,
      required final String id,
      required final List<String> modelIds}) = _$PartModelImpl;

  factory _PartModel.fromJson(Map<String, dynamic> json) =
      _$PartModelImpl.fromJson;

  @override
  String get description;
  @override
  List<String>? get images;
  @override
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  DateTime? get createdAt; // @JsonKey(
//   fromJson: FormatDateTime.timestampFromJson,
//   toJson: FormatDateTime.timestampToJson,
// )
// DateTime? updatedAt,
  @override
  num get price;
  @override
  num get quantity;
  @override
  num get totalPrice;
  @override
  String get id;
  @override
  List<String> get modelIds;

  /// Create a copy of PartModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartModelImplCopyWith<_$PartModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
