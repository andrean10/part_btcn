// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderModelImpl _$$OrderModelImplFromJson(Map<String, dynamic> json) =>
    _$OrderModelImpl(
      createdAt:
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          FormatDateTime.timestampFromJson(json['updatedAt'] as Timestamp?),
      id: json['id'] as String?,
      price: json['price'] as num,
      totalPrice: json['totalPrice'] as num,
      statusPayment: json['statusPayment'] as String?,
      type: json['type'] as String,
      typePayment: json['typePayment'] as String?,
      typeStatus: json['typeStatus'] as String,
      isHasReview: json['isHasReview'] as bool? ?? false,
      discount: json['discount'] as num?,
      isDelete: json['isDelete'] as bool? ?? false,
      userId: json['userId'] as String,
      voucher: json['voucher'] == null
          ? null
          : VoucherModel.fromJson(json['voucher'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$OrderModelImplToJson(_$OrderModelImpl instance) =>
    <String, dynamic>{
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
      'updatedAt': FormatDateTime.timestampToJson(instance.updatedAt),
      'id': instance.id,
      'price': instance.price,
      'totalPrice': instance.totalPrice,
      'statusPayment': instance.statusPayment,
      'type': instance.type,
      'typePayment': instance.typePayment,
      'typeStatus': instance.typeStatus,
      'isHasReview': instance.isHasReview,
      'discount': instance.discount,
      'isDelete': instance.isDelete,
      'userId': instance.userId,
      'voucher': instance.voucher?.toJson(),
    };
