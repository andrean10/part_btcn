import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/helpers/pdf_helper.dart';
import 'package:part_btcn/app/modules/core/main/controllers/main_controller.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../../utils/constants_assets.dart';
import '../../../../data/db/history/order_db.dart';
import '../../init/controllers/init_controller.dart';
import '../../../widgets/buttons/buttons.dart';
import '../../../widgets/modal/modals.dart';
import '../../../widgets/snackbar/snackbar.dart';

class DetailHistoryController extends GetxController {
  late final InitController _initC;
  late final MainController mainC;

  OrderDB? data;

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
      mainC = Get.find<MainController>();
    }

    data = Get.arguments as OrderDB;
  }

  void generateInvoice() => PDFHelper.generateInvoice();

  void pay() {
    final methodPayment = data?.methodPayment;

    if (methodPayment == MethodPayment.transfer) {
      _showModalTransfer();
    }

    if (methodPayment == MethodPayment.qris) {
      _showModalQRIS();
    }
  }

  void _showModalTransfer() {
    Modals.bottomSheet(
      context: Get.context!,
      isDismissible: true,
      content: ListTile(
        leading: SvgPicture.asset(ConstantsAssets.icBCA, width: 32),
        title: const Text('Transfer ke rekening berikut'),
        subtitle: const Text(
          '034-337-3535 a/n PT BUMI CITRA TRAKTOR NUSANTARA',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.copy_rounded),
          onPressed: () async {
            await Clipboard.setData(
              const ClipboardData(text: '0343373535'),
            );
            Snackbar.success(
              context: Get.context!,
              content: 'Nomor rekening berhasil disalin',
            );
            Get.back();
          },
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 8),
      ),
      actions: Buttons.filled(
        width: double.infinity,
        onPressed: Get.back,
        child: const Text('Selesai'),
      ),
    );
  }

  void _showModalQRIS() {
    Modals.bottomSheet(
      context: Get.context!,
      isDismissible: true,
      content: Column(
        children: [
          const SizedBox(width: 16),
          Container(
            width: double.infinity,
            height: 300,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ConstantsAssets.imgQris),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Scan QRIS diatas untuk melakukan pembayaran',
            style: Get.context!.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
        ],
      ),
      actions: Buttons.filled(
        width: double.infinity,
        onPressed: Get.back,
        child: const Text('Selesai'),
      ),
    );
  }

  void acceptPayment() {
    Snackbar.success(
      context: Get.context!,
      content: 'Pembayaran berhasil diterima',
    );
    Get.back();
  }
}
