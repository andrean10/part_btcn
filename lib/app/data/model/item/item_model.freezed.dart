// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'item_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItemModel _$ItemModelFromJson(Map<String, dynamic> json) {
  return _ItemModel.fromJson(json);
}

/// @nodoc
mixin _$ItemModel {
  String? get id => throw _privateConstructorUsedError;
  String get partId => throw _privateConstructorUsedError;
  String get modelId => throw _privateConstructorUsedError;
  num get quantity => throw _privateConstructorUsedError;
  num get price => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this ItemModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ItemModelCopyWith<ItemModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemModelCopyWith<$Res> {
  factory $ItemModelCopyWith(ItemModel value, $Res Function(ItemModel) then) =
      _$ItemModelCopyWithImpl<$Res, ItemModel>;
  @useResult
  $Res call(
      {String? id,
      String partId,
      String modelId,
      num quantity,
      num price,
      String description});
}

/// @nodoc
class _$ItemModelCopyWithImpl<$Res, $Val extends ItemModel>
    implements $ItemModelCopyWith<$Res> {
  _$ItemModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? partId = null,
    Object? modelId = null,
    Object? quantity = null,
    Object? price = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      partId: null == partId
          ? _value.partId
          : partId // ignore: cast_nullable_to_non_nullable
              as String,
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItemModelImplCopyWith<$Res>
    implements $ItemModelCopyWith<$Res> {
  factory _$$ItemModelImplCopyWith(
          _$ItemModelImpl value, $Res Function(_$ItemModelImpl) then) =
      __$$ItemModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String partId,
      String modelId,
      num quantity,
      num price,
      String description});
}

/// @nodoc
class __$$ItemModelImplCopyWithImpl<$Res>
    extends _$ItemModelCopyWithImpl<$Res, _$ItemModelImpl>
    implements _$$ItemModelImplCopyWith<$Res> {
  __$$ItemModelImplCopyWithImpl(
      _$ItemModelImpl _value, $Res Function(_$ItemModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? partId = null,
    Object? modelId = null,
    Object? quantity = null,
    Object? price = null,
    Object? description = null,
  }) {
    return _then(_$ItemModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      partId: null == partId
          ? _value.partId
          : partId // ignore: cast_nullable_to_non_nullable
              as String,
      modelId: null == modelId
          ? _value.modelId
          : modelId // ignore: cast_nullable_to_non_nullable
              as String,
      quantity: null == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as num,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItemModelImpl implements _ItemModel {
  const _$ItemModelImpl(
      {this.id,
      required this.partId,
      required this.modelId,
      required this.quantity,
      required this.price,
      required this.description});

  factory _$ItemModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItemModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String partId;
  @override
  final String modelId;
  @override
  final num quantity;
  @override
  final num price;
  @override
  final String description;

  @override
  String toString() {
    return 'ItemModel(id: $id, partId: $partId, modelId: $modelId, quantity: $quantity, price: $price, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItemModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.partId, partId) || other.partId == partId) &&
            (identical(other.modelId, modelId) || other.modelId == modelId) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, partId, modelId, quantity, price, description);

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ItemModelImplCopyWith<_$ItemModelImpl> get copyWith =>
      __$$ItemModelImplCopyWithImpl<_$ItemModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItemModelImplToJson(
      this,
    );
  }
}

abstract class _ItemModel implements ItemModel {
  const factory _ItemModel(
      {final String? id,
      required final String partId,
      required final String modelId,
      required final num quantity,
      required final num price,
      required final String description}) = _$ItemModelImpl;

  factory _ItemModel.fromJson(Map<String, dynamic> json) =
      _$ItemModelImpl.fromJson;

  @override
  String? get id;
  @override
  String get partId;
  @override
  String get modelId;
  @override
  num get quantity;
  @override
  num get price;
  @override
  String get description;

  /// Create a copy of ItemModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ItemModelImplCopyWith<_$ItemModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
