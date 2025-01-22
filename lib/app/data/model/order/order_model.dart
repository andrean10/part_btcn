import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:part_btcn/app/data/model/item/item_model.dart';

import '../../../helpers/format_date_time.dart';
import '../voucher/voucher_model.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel {
  @JsonSerializable(explicitToJson: true)
  const factory OrderModel({
    @JsonKey(includeFromJson: false, includeToJson: false)
    List<ItemModel>? items,
    String? id,
    required String userId,
    required num price,
    required num totalPrice,
    String? statusPayment,
    required String type,
    String? typePayment,
    required String typeStatus,
    @Default(false) bool isHasReview,
    @Default(false) bool isReturn,
    num? discount,
    VoucherModel? voucher,
    String? reason,
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
  }) = _OrderModel;

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
}
