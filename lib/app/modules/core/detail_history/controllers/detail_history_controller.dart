import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/app/helpers/pdf_helper.dart';
import 'package:part_btcn/app/modules/core/main/controllers/main_controller.dart';
import 'package:part_btcn/app/modules/widgets/dialog/dialogs.dart';
import 'package:part_btcn/utils/constants_keys.dart';

import '../../../../../utils/constants_assets.dart';
import '../../../../data/model/item/item_model.dart';
import '../../init/controllers/init_controller.dart';
import '../../../widgets/buttons/buttons.dart';
import '../../../widgets/modal/modals.dart';
import '../../../widgets/snackbar/snackbar.dart';

class DetailHistoryController extends GetxController {
  late final InitController _initC;
  late final MainController mainC;

  final formKey = GlobalKey<FormState>();
  final reasonC = TextEditingController();

  OrderModel? data;
  var name = '';
  var role = '';

  final reason = ''.obs;

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

    data = Get.arguments as OrderModel;
    name = _initC.localStorage.read(ConstantsKeys.name);
    role = _initC.localStorage.read(ConstantsKeys.role);

    _initListener();
  }

  void _initListener() {
    reasonC.addListener(() => reason.value = reasonC.text);
  }

  CollectionReference<OrderModel> colOrder() {
    final col = _initC.firestore.collection('order').withConverter(
          fromFirestore: (snapshot, _) => OrderModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  CollectionReference<ItemModel> colItems({String? id}) {
    final col = colOrder()
        .doc(id ?? data?.id)
        .collection('items')
        .withConverter(
          fromFirestore: (snapshot, _) => ItemModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  Future<void> generateInvoice() async {
    Dialogs.loading(context: Get.context!);

    try {
      if (data == null) {
        return;
      }

      await PDFHelper.generateInvoicePDF(data, name);
      Snackbar.success(
        context: Get.context!,
        content: 'Invoice berhasil tersimpan di folder BTCN > invoice',
      );
    } catch (e) {
      _initC.logger.e('Error: $e');
    } finally {
      Get.back();
    }
  }

  void acceptPayment() async {
    try {
      await colOrder()
          .doc(data?.id)
          .update({FieldPath.fromString('statusPayment'): 'paid'});
      Snackbar.success(
        context: Get.context!,
        content: 'Pembayaran berhasil diterima',
      );
      Get.back();
    } on FirebaseException catch (e) {
      _initC.logger.e('Error: code = ${e.code}\n${e.message}');
    }
  }

  Future<void> returnPart() async {
    Dialogs.loading(context: Get.context!);

    final now = DateTime.now();
    final newDocOrder = colOrder().doc();
    final newOrder = data?.copyWith.call(
      id: newDocOrder.id,
      type: 'return',
      typeStatus: 'pending',
      isReturn: true,
      reason: reasonC.text.toString().trim(),
      createdAt: now,
      updatedAt: now,
    );
    final parts = newOrder?.items;

    print('newOrder = ${newOrder?.toJson()}');

    if (newOrder != null) {
      try {
        final batch = _initC.firestore.batch();

        // tambahkan order return barang
        batch.set(newDocOrder, newOrder);

        // tambahkan itemsnya
        for (var part in parts!) {
          final newItemDoc = colItems(id: newDocOrder.id).doc();
          batch.set(newItemDoc, part);
        }

        // update data lama menjadi isReturn true
        final oldOrderDoc = colOrder().doc(data?.id);
        batch.update(oldOrderDoc, {'isReturn': true});

        await batch.commit();

        Snackbar.success(
          context: Get.context!,
          content: 'Pengajuan barang berhasil, pengajuanmu sedang dalam review',
        );

        Get.back();
        Get.back();
      } on FirebaseException catch (e) {
        _initC.logger.e('Error: code = ${e.code}\n${e.message}');
      } finally {
        Get.back();
      }
    }
  }

  void pay() {
    final methodPayment = data?.typePayment;

    if (methodPayment == 'transfer') {
      _showModalTransfer();
    }

    if (methodPayment == 'qris') {
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
}
