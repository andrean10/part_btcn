import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/chat/controllers/chat_controller.dart';
import 'package:part_btcn/app/modules/core/home/controllers/home_controller.dart';
import 'package:part_btcn/app/modules/core/profile/controllers/profile_controller.dart';
import 'package:part_btcn/app/modules/core/history_order/controllers/history_order_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(MainController());
    Get.put(HomeController());
    // Get.put(ChatController());
    Get.put(ProfileController());
    // Get.put(HistoryOrderController());
  }
}
