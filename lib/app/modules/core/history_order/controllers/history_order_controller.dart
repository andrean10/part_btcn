import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/data/data_model.dart';
import 'package:part_btcn/app/data/model/item/item_model.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/app/data/model/parts/review/review_model.dart';
import 'package:part_btcn/app/helpers/validations.dart';
import 'package:part_btcn/app/modules/widgets/dialog/dialogs.dart';
import 'package:part_btcn/app/modules/widgets/snackbar/snackbar.dart';
import 'package:part_btcn/app/modules/widgets/textformfield/custom_textform_field.dart';
import 'package:part_btcn/utils/constants_keys.dart';

import '../../../../routes/app_pages.dart';
import '../../init/controllers/init_controller.dart';
import '../../../widgets/buttons/buttons.dart';
import '../../../widgets/modal/modals.dart';

class HistoryOrderController extends GetxController {
  late final InitController _initC;

  var userId = '';
  var _name = '';

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    userId = _initC.localStorage.read(ConstantsKeys.id);
    _name = _initC.localStorage.read(ConstantsKeys.name);
  }

  DocumentReference<DataModel> colModels(String modelId) {
    final col = _initC.firestore
        .collection('models')
        .doc(modelId)
        .withConverter(
          fromFirestore: (snapshot, _) => DataModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  CollectionReference<OrderModel> colHistory() {
    final col = _initC.firestore.collection('order').withConverter(
          fromFirestore: (snapshot, _) => OrderModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  CollectionReference<ItemModel> colItems(String orderId) {
    final col = colHistory().doc(orderId).collection('items').withConverter(
          fromFirestore: (snapshot, _) => ItemModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  CollectionReference<Map<String, dynamic>> colReviews() {
    final col = _initC.firestore.collection('reviews');
    return col;
  }

  void onTap(OrderModel data) {
    Get.toNamed(Routes.DETAIL_HISTORY, arguments: data);
  }

  void showModalReview(OrderModel order) async {
    Dialogs.loading(context: Get.context!);

    try {
      // ambil data koleksi items
      final res = await colItems(order.id ?? '').get();
      final items = res.docs.map((e) => e.data()).toList();
      order = order.copyWith(items: items);

      Get.back();

      await _displayModal(order);
    } on FirebaseException catch (e) {
      _initC.logger.e('Error: code = ${e.code}\n${e.message}');
      Get.back();
    }
  }

  Future<void> _displayModal(OrderModel order) async {
    final formKey = GlobalKey<FormState>();
    final reviewController = TextEditingController();

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
            child: Form(
              key: formKey,
              child: CustomTextFormField(
                controller: reviewController,
                title: 'Review',
                hintText: 'Tuliskan review anda',
                maxLines: 5,
                isFilled: false,
                textInputAction: TextInputAction.done,
                isRequired: true,
                validator: (value) => Validation.formField(
                  titleField: 'Review',
                  value: value,
                  isRequired: true,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
      actions: Buttons.filled(
        width: double.infinity,
        onPressed: () async {
          if (!formKey.currentState!.validate()) {
            return;
          }

          FocusScope.of(Get.context!).unfocus();

          final text = reviewController.text;
          _addReview(order: order, text: text);
        },
        child: const Text('Kirim Ulasan'),
      ),
    );
  }

  Future<void> _addReview(
      {required OrderModel order, required String text}) async {
    Dialogs.loading(context: Get.context!);

    final orderId = order.id;
    final createdAt = DateTime.now();

    try {
      final batch = _initC.firestore.batch();

      for (var item in order.items ?? []) {
        final partId = item.partId;
        final modelId = item.modelId;

        final docReview = colReviews().doc(partId);
        final colSubReview = docReview.collection(modelId).withConverter(
              fromFirestore: (snapshot, _) =>
                  ReviewModel.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson(),
            );

        final subReviewId = colSubReview.doc().id;
        final reviewModel = ReviewModel(
          id: subReviewId,
          userId: userId,
          orderId: orderId ?? '',
          name: _name,
          text: text,
          createdAt: createdAt,
        );

        batch.set(docReview, {'id': partId}, SetOptions(merge: true));
        batch.set(colSubReview.doc(subReviewId), reviewModel);
      }

      // commit batch
      await batch.commit();

      // update user sudah review di order
      await colHistory().doc(orderId).update({'isHasReview': true});

      Get.back();
      Get.back();

      Snackbar.success(
        context: Get.context!,
        content: 'Ulasan berhasil dikirim',
      );
    } on FirebaseException catch (e) {
      _initC.logger.e('Error: code = ${e.code}\n${e.message}');
      Get.back();
    }
  }
}
