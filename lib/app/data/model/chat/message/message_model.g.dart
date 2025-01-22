// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageModelImpl _$$MessageModelImplFromJson(Map<String, dynamic> json) =>
    _$MessageModelImpl(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      text: json['text'] as String,
      createdAt:
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp?),
    );

Map<String, dynamic> _$$MessageModelImplToJson(_$MessageModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      if (instance.userId case final value?) 'userId': value,
      'text': instance.text,
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
    };
