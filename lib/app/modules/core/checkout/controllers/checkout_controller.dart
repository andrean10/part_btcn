import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';
import 'package:part_btcn/app/modules/core/main/controllers/main_controller.dart';
import 'package:part_btcn/app/modules/widgets/dialog/dialogs.dart';
import 'package:part_btcn/app/modules/widgets/snackbar/snackbar.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/modal/modals.dart';

class CheckoutController extends GetxController {
  late final InitController _initC;
  late final MainController _mainC;

  final methodPayment = Rxn<MethodPayment>();
  final methodPaymentName = RxnString();

  final payments = [
    'COD',
    'Transfer',
    'QRIS',
  ];

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    if (Get.isRegistered<MainController>()) {
      _mainC = Get.find<MainController>();
    }
  }

  void showModalMethodPayments() {
    Modals.bottomSheet(
      context: Get.context!,
      content: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(vertical: 12),
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final payment = payments[index];

          return ListTile(
            title: Text(payment),
            onTap: () {
              switch (index) {
                case 0:
                  methodPayment.value = MethodPayment.cash;
                  break;
                case 1:
                  methodPayment.value = MethodPayment.transfer;
                  break;
                case 2:
                  methodPayment.value = MethodPayment.qris;
                  break;
                default:
              }

              methodPaymentName.value = payment;
              Get.back();
            },
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: payments.length,
      ),
    );
  }

  void createCheckout() {
    Dialogs.loading(context: Get.context!);

    Future.delayed(
      3.seconds,
      () {
        Snackbar.success(
          context: Get.context!,
          content: 'Request pesanan barang anda berhasil dibuat',
        );

        switch (methodPayment.value) {
          case MethodPayment.cash:
            Get.offAllNamed(
              Routes.MAIN,
              predicate: (route) => route.isFirst,
            );
            break;
          case MethodPayment.transfer:
            Get.offAllNamed(
              Routes.PAYMENT,
              predicate: (route) => route.isFirst,
              arguments: methodPayment.value,
            );
            break;
          case MethodPayment.qris:
            Get.offAllNamed(
              Routes.PAYMENT,
              predicate: (route) => route.isFirst,
              arguments: methodPayment.value,
            );
            break;
          default:
        }
      },
    );
  }
}
