import 'package:freezed_annotation/freezed_annotation.dart';

part 'discount_model.freezed.dart';
part 'discount_model.g.dart';

@freezed
class DiscountModel with _$DiscountModel {
  const factory DiscountModel({
    required String id,
    required num percent,
  }) = _DiscountModel;

  factory DiscountModel.fromJson(Map<String, dynamic> json) =>
      _$DiscountModelFromJson(json);
}
