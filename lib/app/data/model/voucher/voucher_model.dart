import 'package:freezed_annotation/freezed_annotation.dart';

part 'voucher_model.freezed.dart';
part 'voucher_model.g.dart';

@freezed
class VoucherModel with _$VoucherModel {
  const factory VoucherModel({
    required String id,
    required num fee,
    required num minPrice,
  }) = _VoucherModel;

  factory VoucherModel.fromJson(Map<String, dynamic> json) =>
      _$VoucherModelFromJson(json);
}
