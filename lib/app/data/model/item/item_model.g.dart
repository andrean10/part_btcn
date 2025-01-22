// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ItemModelImpl _$$ItemModelImplFromJson(Map<String, dynamic> json) =>
    _$ItemModelImpl(
      id: json['id'] as String?,
      partId: json['partId'] as String,
      modelId: json['modelId'] as String,
      quantity: json['quantity'] as num,
      price: json['price'] as num,
      description: json['description'] as String,
    );

Map<String, dynamic> _$$ItemModelImplToJson(_$ItemModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partId': instance.partId,
      'modelId': instance.modelId,
      'quantity': instance.quantity,
      'price': instance.price,
      'description': instance.description,
    };
