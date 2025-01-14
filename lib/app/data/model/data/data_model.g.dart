// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataModelImpl _$$DataModelImplFromJson(Map<String, dynamic> json) =>
    _$DataModelImpl(
      parts: (json['parts'] as List<dynamic>?)
          ?.map((e) => PartModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt:
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp),
      updatedAt:
          FormatDateTime.timestampFromJson(json['updatedAt'] as Timestamp),
      id: json['id'] as String,
    );

Map<String, dynamic> _$$DataModelImplToJson(_$DataModelImpl instance) =>
    <String, dynamic>{
      'parts': instance.parts,
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
      'updatedAt': FormatDateTime.timestampToJson(instance.updatedAt),
      'id': instance.id,
    };
