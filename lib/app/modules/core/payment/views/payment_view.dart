import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:part_btcn/shared/shared_enum.dart';
import 'package:part_btcn/utils/constants_assets.dart';

import '../../../widgets/buttons/buttons.dart';
import '../../../widgets/snackbar/snackbar.dart';
import '../controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {
  const PaymentView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pembayaran'),
        centerTitle: true,
      ),
      body: switch (controller.methodPayment) {
        MethodPayment.transfer => Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 42),
              child: Column(
                children: [
                  SvgPicture.asset(ConstantsAssets.icBCA),
                  const SizedBox(height: 12),
                  const AutoSizeText(
                    'Lakukan transfer pada nomor rekening berikut',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  const AutoSizeText(
                    '034-337-3535 a/n PT BUMI CITRA TRAKTOR NUSANTARA',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  FilledButton.icon(
                    onPressed: () async {
                      await Clipboard.setData(
                        const ClipboardData(text: '0343373535'),
                      );
                      Snackbar.success(
                        context: Get.context!,
                        content: 'Nomor rekening berhasil disalin',
                      );
                    },
                    label: const Text('Salin Kode'),
                    icon: const Icon(Icons.copy_rounded),
                  ),
                ],
              ),
            ),
          ),
        MethodPayment.qris => Padding(
            padding: const EdgeInsets.all(42),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    ConstantsAssets.imgQris,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(height: 21),
                  AutoSizeText(
                    'Scan QRIS diatas untuk melakukan pembayaran',
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        MethodPayment.cash => const SizedBox.shrink(),
      },
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Buttons.filled(
            width: double.infinity,
            onPressed: Get.back,
            child: const Text('Selesai'),
          ),
        )
      ],
    );
  }
}
