import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';

import '../../../../routes/app_pages.dart';


class CartController extends GetxController {
  late final InitController _initC;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }
  }

  void moveToCheckout() => Get.toNamed(Routes.CHECKOUT);
}
