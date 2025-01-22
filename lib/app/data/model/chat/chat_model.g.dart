// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatModelImpl _$$ChatModelImplFromJson(Map<String, dynamic> json) =>
    _$ChatModelImpl(
      id: json['id'] as String,
      lastMessage: json['lastMessage'] == null
          ? null
          : MessageModel.fromJson(json['lastMessage'] as Map<String, dynamic>),
      createdAt:
          FormatDateTime.timestampFromJson(json['createdAt'] as Timestamp?),
      userName: json['userName'] as String?,
    );

Map<String, dynamic> _$$ChatModelImplToJson(_$ChatModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lastMessage': instance.lastMessage?.toJson(),
      'createdAt': FormatDateTime.timestampToJson(instance.createdAt),
      'userName': instance.userName,
    };
