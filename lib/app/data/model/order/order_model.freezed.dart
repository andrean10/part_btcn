// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ItemModel>? get items => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  num get price => throw _privateConstructorUsedError;
  num get totalPrice => throw _privateConstructorUsedError;
  String? get statusPayment => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  String? get typePayment => throw _privateConstructorUsedError;
  String get typeStatus => throw _privateConstructorUsedError;
  bool get isHasReview => throw _privateConstructorUsedError;
  bool get isReturn => throw _privateConstructorUsedError;
  num? get discount => throw _privateConstructorUsedError;
  VoucherModel? get voucher => throw _privateConstructorUsedError;
  String? get reason => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson)
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this OrderModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      List<ItemModel>? items,
      String? id,
      String userId,
      num price,
      num totalPrice,
      String? statusPayment,
      String type,
      String? typePayment,
      String typeStatus,
      bool isHasReview,
      bool isReturn,
      num? discount,
      VoucherModel? voucher,
      String? reason,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? createdAt,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? updatedAt});

  $VoucherModelCopyWith<$Res>? get voucher;
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? id = freezed,
    Object? userId = null,
    Object? price = null,
    Object? totalPrice = null,
    Object? statusPayment = freezed,
    Object? type = null,
    Object? typePayment = freezed,
    Object? typeStatus = null,
    Object? isHasReview = null,
    Object? isReturn = null,
    Object? discount = freezed,
    Object? voucher = freezed,
    Object? reason = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as num,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      typePayment: freezed == typePayment
          ? _value.typePayment
          : typePayment // ignore: cast_nullable_to_non_nullable
              as String?,
      typeStatus: null == typeStatus
          ? _value.typeStatus
          : typeStatus // ignore: cast_nullable_to_non_nullable
              as String,
      isHasReview: null == isHasReview
          ? _value.isHasReview
          : isHasReview // ignore: cast_nullable_to_non_nullable
              as bool,
      isReturn: null == isReturn
          ? _value.isReturn
          : isReturn // ignore: cast_nullable_to_non_nullable
              as bool,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as num?,
      voucher: freezed == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as VoucherModel?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
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

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $VoucherModelCopyWith<$Res>? get voucher {
    if (_value.voucher == null) {
      return null;
    }

    return $VoucherModelCopyWith<$Res>(_value.voucher!, (value) {
      return _then(_value.copyWith(voucher: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$OrderModelImplCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$OrderModelImplCopyWith(
          _$OrderModelImpl value, $Res Function(_$OrderModelImpl) then) =
      __$$OrderModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      List<ItemModel>? items,
      String? id,
      String userId,
      num price,
      num totalPrice,
      String? statusPayment,
      String type,
      String? typePayment,
      String typeStatus,
      bool isHasReview,
      bool isReturn,
      num? discount,
      VoucherModel? voucher,
      String? reason,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? createdAt,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      DateTime? updatedAt});

  @override
  $VoucherModelCopyWith<$Res>? get voucher;
}

/// @nodoc
class __$$OrderModelImplCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$OrderModelImpl>
    implements _$$OrderModelImplCopyWith<$Res> {
  __$$OrderModelImplCopyWithImpl(
      _$OrderModelImpl _value, $Res Function(_$OrderModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? id = freezed,
    Object? userId = null,
    Object? price = null,
    Object? totalPrice = null,
    Object? statusPayment = freezed,
    Object? type = null,
    Object? typePayment = freezed,
    Object? typeStatus = null,
    Object? isHasReview = null,
    Object? isReturn = null,
    Object? discount = freezed,
    Object? voucher = freezed,
    Object? reason = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$OrderModelImpl(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<ItemModel>?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as num,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as num,
      statusPayment: freezed == statusPayment
          ? _value.statusPayment
          : statusPayment // ignore: cast_nullable_to_non_nullable
              as String?,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      typePayment: freezed == typePayment
          ? _value.typePayment
          : typePayment // ignore: cast_nullable_to_non_nullable
              as String?,
      typeStatus: null == typeStatus
          ? _value.typeStatus
          : typeStatus // ignore: cast_nullable_to_non_nullable
              as String,
      isHasReview: null == isHasReview
          ? _value.isHasReview
          : isHasReview // ignore: cast_nullable_to_non_nullable
              as bool,
      isReturn: null == isReturn
          ? _value.isReturn
          : isReturn // ignore: cast_nullable_to_non_nullable
              as bool,
      discount: freezed == discount
          ? _value.discount
          : discount // ignore: cast_nullable_to_non_nullable
              as num?,
      voucher: freezed == voucher
          ? _value.voucher
          : voucher // ignore: cast_nullable_to_non_nullable
              as VoucherModel?,
      reason: freezed == reason
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String?,
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

@JsonSerializable(explicitToJson: true)
class _$OrderModelImpl with DiagnosticableTreeMixin implements _OrderModel {
  const _$OrderModelImpl(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final List<ItemModel>? items,
      this.id,
      required this.userId,
      required this.price,
      required this.totalPrice,
      this.statusPayment,
      required this.type,
      this.typePayment,
      required this.typeStatus,
      this.isHasReview = false,
      this.isReturn = false,
      this.discount,
      this.voucher,
      this.reason,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      this.createdAt,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      this.updatedAt})
      : _items = items;

  factory _$OrderModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderModelImplFromJson(json);

  final List<ItemModel>? _items;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ItemModel>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? id;
  @override
  final String userId;
  @override
  final num price;
  @override
  final num totalPrice;
  @override
  final String? statusPayment;
  @override
  final String type;
  @override
  final String? typePayment;
  @override
  final String typeStatus;
  @override
  @JsonKey()
  final bool isHasReview;
  @override
  @JsonKey()
  final bool isReturn;
  @override
  final num? discount;
  @override
  final VoucherModel? voucher;
  @override
  final String? reason;
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
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'OrderModel(items: $items, id: $id, userId: $userId, price: $price, totalPrice: $totalPrice, statusPayment: $statusPayment, type: $type, typePayment: $typePayment, typeStatus: $typeStatus, isHasReview: $isHasReview, isReturn: $isReturn, discount: $discount, voucher: $voucher, reason: $reason, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'OrderModel'))
      ..add(DiagnosticsProperty('items', items))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('userId', userId))
      ..add(DiagnosticsProperty('price', price))
      ..add(DiagnosticsProperty('totalPrice', totalPrice))
      ..add(DiagnosticsProperty('statusPayment', statusPayment))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('typePayment', typePayment))
      ..add(DiagnosticsProperty('typeStatus', typeStatus))
      ..add(DiagnosticsProperty('isHasReview', isHasReview))
      ..add(DiagnosticsProperty('isReturn', isReturn))
      ..add(DiagnosticsProperty('discount', discount))
      ..add(DiagnosticsProperty('voucher', voucher))
      ..add(DiagnosticsProperty('reason', reason))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.statusPayment, statusPayment) ||
                other.statusPayment == statusPayment) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.typePayment, typePayment) ||
                other.typePayment == typePayment) &&
            (identical(other.typeStatus, typeStatus) ||
                other.typeStatus == typeStatus) &&
            (identical(other.isHasReview, isHasReview) ||
                other.isHasReview == isHasReview) &&
            (identical(other.isReturn, isReturn) ||
                other.isReturn == isReturn) &&
            (identical(other.discount, discount) ||
                other.discount == discount) &&
            (identical(other.voucher, voucher) || other.voucher == voucher) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_items),
      id,
      userId,
      price,
      totalPrice,
      statusPayment,
      type,
      typePayment,
      typeStatus,
      isHasReview,
      isReturn,
      discount,
      voucher,
      reason,
      createdAt,
      updatedAt);

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      __$$OrderModelImplCopyWithImpl<_$OrderModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderModelImplToJson(
      this,
    );
  }
}

abstract class _OrderModel implements OrderModel {
  const factory _OrderModel(
      {@JsonKey(includeFromJson: false, includeToJson: false)
      final List<ItemModel>? items,
      final String? id,
      required final String userId,
      required final num price,
      required final num totalPrice,
      final String? statusPayment,
      required final String type,
      final String? typePayment,
      required final String typeStatus,
      final bool isHasReview,
      final bool isReturn,
      final num? discount,
      final VoucherModel? voucher,
      final String? reason,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      final DateTime? createdAt,
      @JsonKey(
          fromJson: FormatDateTime.timestampFromJson,
          toJson: FormatDateTime.timestampToJson)
      final DateTime? updatedAt}) = _$OrderModelImpl;

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$OrderModelImpl.fromJson;

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  List<ItemModel>? get items;
  @override
  String? get id;
  @override
  String get userId;
  @override
  num get price;
  @override
  num get totalPrice;
  @override
  String? get statusPayment;
  @override
  String get type;
  @override
  String? get typePayment;
  @override
  String get typeStatus;
  @override
  bool get isHasReview;
  @override
  bool get isReturn;
  @override
  num? get discount;
  @override
  VoucherModel? get voucher;
  @override
  String? get reason;
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

  /// Create a copy of OrderModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderModelImplCopyWith<_$OrderModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
