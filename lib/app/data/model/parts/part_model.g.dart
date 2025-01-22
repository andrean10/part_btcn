// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'part_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PartModelImpl _$$PartModelImplFromJson(Map<String, dynamic> json) =>
    _$PartModelImpl(
      description: json['description'] as String? ?? '-',
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
      createdAt:
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp?),
      price: json['price'] as num? ?? 0,
      quantity: json['quantity'] as num? ?? 0,
      totalPrice: json['totalPrice'] as num? ?? 0,
      id: json['id'] as String,
      modelIds:
          (json['modelIds'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$PartModelImplToJson(_$PartModelImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'images': instance.images,
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
      'price': instance.price,
      'quantity': instance.quantity,
      'totalPrice': instance.totalPrice,
      'id': instance.id,
      'modelIds': instance.modelIds,
    };
