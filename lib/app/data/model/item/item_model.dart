import 'package:freezed_annotation/freezed_annotation.dart';

part 'item_model.freezed.dart';
part 'item_model.g.dart';

@freezed
class ItemModel with _$ItemModel {
  const factory ItemModel({
    String? id,
    required String partId,
    required String modelId,
    required num quantity,
    required num price,
    required String description,
  }) = _ItemModel;

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);
}
