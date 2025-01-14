import 'package:get/get.dart';

import '../controllers/detail_part_controller.dart';

class DetailPartBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPartController>(
      () => DetailPartController(),
    );
  }
}
