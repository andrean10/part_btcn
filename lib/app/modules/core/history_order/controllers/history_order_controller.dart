import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/modules/widgets/textformfield/custom_textform_field.dart';

import '../../../../data/db/history/order_db.dart';
import '../../../../routes/app_pages.dart';
import '../../init/controllers/init_controller.dart';
import '../../../widgets/buttons/buttons.dart';
import '../../../widgets/modal/modals.dart';

class HistoryOrderController extends GetxController {
  late final InitController initC;

  final reviewsC = RxList<TextEditingController>.empty();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }

    for (var i = 0; i < initC.dummyHistory.length; i++) {
      reviewsC.add(TextEditingController());
    }
  }

  void onTap(OrderDB data) {
    final status = data.statusApproval;
    final statusPayment = data.statusPayment;
    final methodPayment = data.methodPayment;
    final textTheme = Get.context!.textTheme;

    Get.toNamed(Routes.DETAIL_HISTORY, arguments: data);

    // if (status == StatusApproval.approved) {
    //   // belum bayar
    //   if (statusPayment == StatusPayment.credit) {
    //     if (methodPayment == MethodPayment.qris) {
    //       Modals.bottomSheet(
    //         context: Get.context!,
    //         isDismissible: true,
    //         content: Column(
    //           children: [
    //             Padding(
    //               padding: EdgeInsets.zero,
    //               child: Container(
    //                 width: double.infinity,
    //                 height: 300,
    //                 decoration: const BoxDecoration(
    //                   image: DecorationImage(
    //                     image: AssetImage(ConstantsAssets.imgQris),
    //                     // fit: BoxFit.cover,
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const SizedBox(height: 16),
    //             Text(
    //               'Scan QRIS diatas untuk melakukan pembayaran',
    //               style: textTheme.titleMedium,
    //               textAlign: TextAlign.center,
    //             ),
    //             const SizedBox(height: 16),
    //           ],
    //         ),
    //         actions: Buttons.filled(
    //           width: double.infinity,
    //           onPressed: Get.back,
    //           child: const Text('Selesai'),
    //         ),
    //       );
    //     }

    //     if (methodPayment == MethodPayment.transfer) {
    //       Modals.bottomSheet(
    //         context: Get.context!,
    //         isDismissible: true,
    //         content: ListTile(
    //           leading: SvgPicture.asset(ConstantsAssets.icBCA, width: 32),
    //           title: const Text('Transfer ke rekening berikut'),
    //           subtitle: const Text(
    //             '034-337-3535 a/n PT BUMI CITRA TRAKTOR NUSANTARA',
    //           ),
    //           trailing: IconButton(
    //             icon: const Icon(Icons.copy_rounded),
    //             onPressed: () async {
    //               await Clipboard.setData(
    //                 const ClipboardData(text: '0343373535'),
    //               );
    //               Snackbar.success(
    //                 context: Get.context!,
    //                 content: 'Nomor rekening berhasil disalin',
    //               );
    //               Get.back();
    //             },
    //           ),
    //           contentPadding: const EdgeInsets.symmetric(vertical: 8),
    //         ),
    //         actions: Buttons.filled(
    //           width: double.infinity,
    //           onPressed: Get.back,
    //           child: const Text('Selesai'),
    //         ),
    //       );
    //     }

    //     if (methodPayment == MethodPayment.cash) {}
    //   }

    //   if (statusPayment == StatusPayment.paid) {
    //     // Get.toNamed(Routes.DETAIL_HISTORY, arguments: );
    //   }
    // }

    // Get.toNamed(Routes.DETAIL_ADMIN);
  }

  void showModalReview(int index) {
    Modals.bottomSheet(
      context: Get.context!,
      isDismissible: true,
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            child: CustomTextFormField(
              controller: reviewsC[index],
              title: 'Review',
              hintText: 'Tuliskan review anda',
              maxLines: 5,
              isFilled: false,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (value) => Get.back(),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      actions: Buttons.filled(
        width: double.infinity,
        onPressed: Get.back,
        child: const Text('Kirim Ulasan'),
      ),
    );
  }
}
