import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';

import '../../../../../utils/constants_keys.dart';
import '../../../../data/model/item/item_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/dialog/dialogs.dart';

class CartController extends GetxController {
  late final InitController _initC;

  final items = RxList<ItemModel>.empty(growable: true);
  String _userId = '';

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    _initStorage();
  }

  void _initStorage() {
    _userId = _initC.localStorage.read(ConstantsKeys.id);
    final data = _initC.localStorage.read(ConstantsKeys.cart);

    if (data is List<ItemModel>) {
      items.addAll(data);
    }
  }

  void moveToCheckout() {
    final totalPrice = items.value.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity).toInt(),
    );

    final order = OrderModel(
      items: items,
      totalPrice: totalPrice,
      type: 'request',
      typeStatus: 'pending',
      userId: _userId,
      price: 0,
    );

    print('order = ${order.toJson()}');

    Get.toNamed(Routes.CHECKOUT, arguments: order);
  }

  Future<void> clearItems() async {
    try {
      items.clear();
      await _initC.localStorage.remove(ConstantsKeys.cart);
    } catch (e) {
      _initC.logger.e('Error: $e');
    }
  }

  Future<void> deleteItem(ItemModel item) async {
    final result = await Dialogs.alert(
      context: Get.context!,
      title: 'Perhatian',
      content: const Text('Apakah anda yakin ingin menghapus item ini?'),
    );

    if (result != null && result) {
      items.remove(item);
      await _initC.localStorage.write(ConstantsKeys.cart, items);
    }
  }
}
