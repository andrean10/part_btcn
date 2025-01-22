// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$VoucherModelImpl _$$VoucherModelImplFromJson(Map<String, dynamic> json) =>
    _$VoucherModelImpl(
      id: json['id'] as String,
      fee: json['fee'] as num,
      minPrice: json['minPrice'] as num,
    );

Map<String, dynamic> _$$VoucherModelImplToJson(_$VoucherModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fee': instance.fee,
      'minPrice': instance.minPrice,
    };
