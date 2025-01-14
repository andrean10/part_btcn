import 'package:get/get.dart';
import 'package:part_btcn/utils/constants_keys.dart';

import '../../../../../shared/shared_method.dart';
import '../../../../routes/app_pages.dart';
import '../../init/controllers/init_controller.dart';

class SplashController extends GetxController {
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

    Future.delayed(3.seconds, _checkAuth);
  }

  void _checkAuth() {
    final users = _initC.auth.currentUser;

    if (users != null) {
      _moveToMain();
    } else {
      _moveToAuth();
    }
  }

  void _moveToAuth() => Get.offAllNamed(Routes.AUTH);

  void _moveToMain() {
    final roleUser = _initC.localStorage.read<String>(ConstantsKeys.role);
    final role = checkRole(roleUser);
    Get.offAllNamed(Routes.MAIN, arguments: role);
  }
}
