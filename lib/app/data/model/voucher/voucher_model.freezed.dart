// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'voucher_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

VoucherModel _$VoucherModelFromJson(Map<String, dynamic> json) {
  return _VoucherModel.fromJson(json);
}

/// @nodoc
mixin _$VoucherModel {
  String get id => throw _privateConstructorUsedError;
  num get fee => throw _privateConstructorUsedError;
  num get minPrice => throw _privateConstructorUsedError;

  /// Serializes this VoucherModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $VoucherModelCopyWith<VoucherModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $VoucherModelCopyWith<$Res> {
  factory $VoucherModelCopyWith(
          VoucherModel value, $Res Function(VoucherModel) then) =
      _$VoucherModelCopyWithImpl<$Res, VoucherModel>;
  @useResult
  $Res call({String id, num fee, num minPrice});
}

/// @nodoc
class _$VoucherModelCopyWithImpl<$Res, $Val extends VoucherModel>
    implements $VoucherModelCopyWith<$Res> {
  _$VoucherModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fee = null,
    Object? minPrice = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as num,
      minPrice: null == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as num,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$VoucherModelImplCopyWith<$Res>
    implements $VoucherModelCopyWith<$Res> {
  factory _$$VoucherModelImplCopyWith(
          _$VoucherModelImpl value, $Res Function(_$VoucherModelImpl) then) =
      __$$VoucherModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, num fee, num minPrice});
}

/// @nodoc
class __$$VoucherModelImplCopyWithImpl<$Res>
    extends _$VoucherModelCopyWithImpl<$Res, _$VoucherModelImpl>
    implements _$$VoucherModelImplCopyWith<$Res> {
  __$$VoucherModelImplCopyWithImpl(
      _$VoucherModelImpl _value, $Res Function(_$VoucherModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? fee = null,
    Object? minPrice = null,
  }) {
    return _then(_$VoucherModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      fee: null == fee
          ? _value.fee
          : fee // ignore: cast_nullable_to_non_nullable
              as num,
      minPrice: null == minPrice
          ? _value.minPrice
          : minPrice // ignore: cast_nullable_to_non_nullable
              as num,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$VoucherModelImpl implements _VoucherModel {
  const _$VoucherModelImpl(
      {required this.id, required this.fee, required this.minPrice});

  factory _$VoucherModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$VoucherModelImplFromJson(json);

  @override
  final String id;
  @override
  final num fee;
  @override
  final num minPrice;

  @override
  String toString() {
    return 'VoucherModel(id: $id, fee: $fee, minPrice: $minPrice)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$VoucherModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.fee, fee) || other.fee == fee) &&
            (identical(other.minPrice, minPrice) ||
                other.minPrice == minPrice));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, fee, minPrice);

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$VoucherModelImplCopyWith<_$VoucherModelImpl> get copyWith =>
      __$$VoucherModelImplCopyWithImpl<_$VoucherModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$VoucherModelImplToJson(
      this,
    );
  }
}

abstract class _VoucherModel implements VoucherModel {
  const factory _VoucherModel(
      {required final String id,
      required final num fee,
      required final num minPrice}) = _$VoucherModelImpl;

  factory _VoucherModel.fromJson(Map<String, dynamic> json) =
      _$VoucherModelImpl.fromJson;

  @override
  String get id;
  @override
  num get fee;
  @override
  num get minPrice;

  /// Create a copy of VoucherModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$VoucherModelImplCopyWith<_$VoucherModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
