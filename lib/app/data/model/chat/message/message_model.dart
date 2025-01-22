import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../../helpers/format_date_time.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const factory MessageModel({
    required String id,
    @JsonKey(includeIfNull: false) String? userId,
    required String text,
    @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson,
    )
    DateTime? createdAt,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);
}
