import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../helpers/format_date_time.dart';

part 'data_model.freezed.dart';
part 'data_model.g.dart';

@freezed
class DataModel with _$DataModel {
  const factory DataModel({
    // List<PartModel>? parts,
    required String id,
    required List<String> partIds,
    @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson,
    )
    DateTime? createdAt,
    @JsonKey(
      fromJson: FormatDateTime.timestampFromJson,
      toJson: FormatDateTime.timestampToJson,
    )
    DateTime? updatedAt,
  }) = _DataModel;

  factory DataModel.fromJson(Map<String, dynamic> json) =>
      _$DataModelFromJson(json);
}
