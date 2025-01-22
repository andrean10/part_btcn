import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/app/data/model/voucher/voucher_model.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';
import 'package:part_btcn/app/modules/widgets/dialog/dialogs.dart';
import 'package:part_btcn/app/modules/widgets/snackbar/snackbar.dart';
import 'package:part_btcn/utils/constants_keys.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../routes/app_pages.dart';
import '../../../widgets/modal/modals.dart';

class CheckoutController extends GetxController {
  late final InitController _initC;
  // late final MainController _mainC;

  String? _userId;
  OrderModel? order;
  final voucher = Rxn<VoucherModel>();
  final totalPrice = 0.obs;

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

    // if (Get.isRegistered<MainController>()) {
    //   _mainC = Get.find<MainController>();
    // }

    _userId = _initC.localStorage.read(ConstantsKeys.id);

    order = Get.arguments as OrderModel;
    totalPrice.value = order?.totalPrice.toInt() ?? 0;

    _fetchVouchers();
  }

  Future<void> _fetchVouchers() async {
    try {
      // AMBIL VOUCHER YANG SESUAI FILTER MINIMAL PEMBELANJAAN
      final queryVouchers = await _initC.firestore
          .collection('vouchers')
          .withConverter(
            fromFirestore: (snapshot, _) =>
                VoucherModel.fromJson(snapshot.data()!),
            toFirestore: (model, _) => model.toJson(),
          )
          .where(
            FieldPath.fromString('minPrice'),
            isLessThanOrEqualTo: order?.totalPrice,
          )
          .orderBy(FieldPath.fromString('fee'), descending: true)
          .limit(1)
          .get();

      //  cek minimal voucher dan minimal pembayaran
      if (queryVouchers.size != 0) {
        voucher.value = queryVouchers.docs.first.data();

        // ubah total price
        totalPrice.value -= voucher.value!.fee.toInt();
      }
    } on FirebaseException catch (e) {
      _initC.logger.e('Error: code = ${e.code}\n${e.message}');
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

  Future<void> createCheckout() async {
    if (order != null) {
      Dialogs.loading(context: Get.context!);

      try {
        // update data order
        final col = _initC.firestore.collection('order');
        final newDocOrder = col.doc();
        final now = DateTime.now();

        order = order?.copyWith(
          id: newDocOrder.id,
          totalPrice: totalPrice.value,
          typePayment: methodPayment.value?.name.toLowerCase(),
          statusPayment: 'credit',
          createdAt: now,
          updatedAt: now,
          userId: _userId ?? '',
          voucher: VoucherModel.fromJson(voucher.value!.toJson()),
        );

        print('order = ${order?.toJson()}');

        await col.doc(newDocOrder.id).set(order!.toJson());

        final batch = _initC.firestore.batch();
        final collectionRef = col.doc(newDocOrder.id).collection('items');

        order?.items?.forEach(
          (data) {
            final newDoc = collectionRef.doc(); // Generate a new document ID
            final newData = data.copyWith(id: newDoc.id);
            batch.set(newDoc, newData.toJson()); // Add the data to the batch
          },
        );

        await batch.commit();
        await _initC.localStorage.remove(ConstantsKeys.cart);

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
      } on FirebaseException catch (e) {
        _initC.logger.e('Error: code = ${e.code}\n${e.message}');
      }
    }
  }
}
