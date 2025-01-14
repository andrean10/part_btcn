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
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp),
      updatedAt:
          FormatDateTime.timestampFromJson(json['updatedAt'] as Timestamp),
      price: (json['price'] as num?)?.toInt() ?? 0,
      id: json['id'] as String,
      reviews: (json['reviews'] as List<dynamic>?)
          ?.map((e) => ReviewModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$PartModelImplToJson(_$PartModelImpl instance) =>
    <String, dynamic>{
      'description': instance.description,
      'images': instance.images,
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
      'updatedAt': FormatDateTime.timestampToJson(instance.updatedAt),
      'price': instance.price,
      'id': instance.id,
      'reviews': instance.reviews,
    };
