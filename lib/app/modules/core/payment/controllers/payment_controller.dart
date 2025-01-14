import 'package:get/get.dart';
import 'package:part_btcn/shared/shared_enum.dart';

class PaymentController extends GetxController {
  late final MethodPayment methodPayment;

  @override
  void onInit() {
    super.onInit();

    methodPayment = Get.arguments as MethodPayment;
  }
}
