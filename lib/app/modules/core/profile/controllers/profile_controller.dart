import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';
import 'package:part_btcn/utils/constants_keys.dart';

import '../../../widgets/dialog/dialogs.dart';

class ProfileController extends GetxController {
  late final InitController _initC;

  var name = '-';
  var email = '-';
  var role = '-';

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }
    _prepareDataProfile();
  }

  void _prepareDataProfile() {
    name = _initC.localStorage.read(ConstantsKeys.name);
    email = _initC.localStorage.read(ConstantsKeys.email);
    role = _initC.localStorage.read(ConstantsKeys.role).toString()?.capitalizeFirst ?? '-';
  }

  Future<void> logout() async {
    final result = await Dialogs.logout(context: Get.context!);

    if (result != null) {
      if (result) {
        await _initC.logout();
      }
    }
  }
}
