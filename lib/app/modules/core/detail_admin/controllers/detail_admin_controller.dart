import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/db/nav_item_admin/part.dart';

import '../../../../../shared/shared_enum.dart';
import '../../init/controllers/init_controller.dart';
import '../../../widgets/snackbar/snackbar.dart';

class DetailAdminController extends GetxController {
  late final InitController _initC;

  // List<Part>? parts;

  final quantityC = TextEditingController(text: '1');
  final discountC = TextEditingController(text: '0');

  final quantityF = FocusNode();

  final status = StatusApproval.pending.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    // parts = Get.arguments as List<Part>?;
    status.value = Get.arguments as StatusApproval;
  }

  void changeStatus(StatusApproval value) {
    Snackbar.success(
      context: Get.context!,
      content: 'Data berhasil di ${value.name}',
    );
    // status.value = value;
    // Get.back();
  }
}
