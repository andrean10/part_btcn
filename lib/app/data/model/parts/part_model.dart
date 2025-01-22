import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/format_date_time.dart';
import 'review/review_model.dart';

part 'part_model.freezed.dart';
part 'part_model.g.dart';

@freezed
class PartModel with _$PartModel {
  const factory PartModel({
    @Default('-') String description,
    List<String>? images,
    @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson,
    )
    DateTime? createdAt,
    // @JsonKey(
    //   fromJson: FormatDateTime.timestampFromJson,
    //   toJson: FormatDateTime.timestampToJson,
    // )
    // DateTime? updatedAt,
    @Default(0) num price,
    @Default(0) num quantity,
    @Default(0) num totalPrice,
    required String id,
    required List<String> modelIds,
    // List<ReviewModel>? reviews,
  }) = _PartModel;

  factory PartModel.fromJson(Map<String, dynamic> json) =>
      _$PartModelFromJson(json);
}
