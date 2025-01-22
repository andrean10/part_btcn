import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/item/item_model.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../data/model/order/order_model.dart';
import '../../init/controllers/init_controller.dart';
import '../../../widgets/snackbar/snackbar.dart';

class DetailAdminController extends GetxController {
  late final InitController _initC;

  OrderModel? data;

  final quantityC = TextEditingController(text: '1');
  final discountC = TextEditingController(text: '0');

  final quantityF = FocusNode();

  final totalPrice = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    data = Get.arguments as OrderModel;
    totalPrice.value = data?.totalPrice.toInt() ?? 0;

    _initTextCListener();
  }

  void _initTextCListener() {
    discountC.addListener(_calculateTotalPrice);
  }

  void _calculateTotalPrice() {
    final totalPricee = data?.totalPrice.toInt() ?? 0;
    final discountPercent = int.tryParse(discountC.text) ?? 0;
    final amountDiscountPercent = totalPricee * discountPercent / 100;
    totalPrice.value = totalPricee - amountDiscountPercent.toInt();
  }

  CollectionReference<ItemModel> colItems() {
    final col = _initC.firestore
        .collection('order')
        .doc(data?.id)
        .collection('items')
        .withConverter(
          fromFirestore: (snapshot, _) => ItemModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  Future<void> changeStatus(StatusApproval value) async {
    try {
      final updateData = {
        FieldPath.fromString('typeStatus'): value.name.toLowerCase(),
        FieldPath.fromString('discount'): int.tryParse(discountC.text) ?? 0,
        FieldPath.fromString('totalPrice'): totalPrice.value,
      };

      await _initC.firestore
          .collection('order')
          .doc(data?.id)
          .update(updateData);

      Snackbar.success(
        context: Get.context!,
        content: 'Data berhasil di ${value.name}',
      );
      Get.back();
    } on FirebaseException catch (e) {
      _initC.logger.e('Error: code = ${e.code}\n${e.message}');
    }
  }
}
