// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      id: json['id'] as String?,
      userId: json['userId'] as String,
      price: json['price'] as num,
      totalPrice: json['totalPrice'] as num,
      statusPayment: json['statusPayment'] as String?,
      type: json['type'] as String,
      typePayment: json['typePayment'] as String?,
      typeStatus: json['typeStatus'] as String,
      isHasReview: json['isHasReview'] as bool? ?? false,
      isReturn: json['isReturn'] as bool? ?? false,
      discount: json['discount'] as num?,
      voucher: json['voucher'] == null
          ? null
          : VoucherModel.fromJson(json['voucher'] as Map<String, dynamic>),
      reason: json['reason'] as String?,
      createdAt:
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          FormatDateTime.timestampFromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'price': instance.price,
      'totalPrice': instance.totalPrice,
      'statusPayment': instance.statusPayment,
      'type': instance.type,
      'typePayment': instance.typePayment,
      'typeStatus': instance.typeStatus,
      'isHasReview': instance.isHasReview,
      'isReturn': instance.isReturn,
      'discount': instance.discount,
      'voucher': instance.voucher?.toJson(),
      'reason': instance.reason,
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
      'updatedAt': FormatDateTime.timestampToJson(instance.updatedAt),
    };
