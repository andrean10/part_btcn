// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DataModelImpl _$$DataModelImplFromJson(Map<String, dynamic> json) =>
    _$DataModelImpl(
      id: json['id'] as String,
      partIds:
          (json['partIds'] as List<dynamic>).map((e) => e as String).toList(),
      createdAt:
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp?),
      updatedAt:
          FormatDateTime.timestampFromJson(json['updatedAt'] as Timestamp?),
    );

Map<String, dynamic> _$$DataModelImplToJson(_$DataModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partIds': instance.partIds,
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
      'updatedAt': FormatDateTime.timestampToJson(instance.updatedAt),
    };
