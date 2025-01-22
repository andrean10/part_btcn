import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:part_btcn/app/data/model/chat/message/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../helpers/format_date_time.dart';

part 'chat_model.freezed.dart';
part 'chat_model.g.dart';

@freezed
class ChatModel with _$ChatModel {
  const factory ChatModel({
    required String id,
    @JsonKey(includeIfNull: false) MessageModel? lastMessage,
    @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson,
    )
    DateTime? createdAt,
  }) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
      _$ChatModelFromJson(json);
}
