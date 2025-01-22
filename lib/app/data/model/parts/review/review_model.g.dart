// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReviewModelImpl _$$ReviewModelImplFromJson(Map<String, dynamic> json) =>
    _$ReviewModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      orderId: json['orderId'] as String,
      name: json['name'] as String,
      text: json['text'] as String,
      createdAt:
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$ReviewModelImplToJson(_$ReviewModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'orderId': instance.orderId,
      'name': instance.name,
      'text': instance.text,
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
    };
