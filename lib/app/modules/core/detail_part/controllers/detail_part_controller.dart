import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/item/item_model.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/app/data/model/parts/part_model.dart';
import 'package:part_btcn/app/data/model/parts/review/review_model.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';
import 'package:part_btcn/app/modules/widgets/snackbar/snackbar.dart';
import 'package:part_btcn/utils/constants_keys.dart';

import '../../../../routes/app_pages.dart';
import '../../../widgets/dialog/dialogs.dart';

class DetailPartController extends GetxController {
  late final InitController _initC;

  String? _userId;
  PartModel? dataPart;
  String? modelId;

  final _itemsModal = List<ItemModel>.empty(growable: true);
  final totalItemsCart = 0.obs;
  final quantity = 1.obs;
  final totalPrice = 0.obs;

  final carts = RxList<String>.empty();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    _initStorage();
    _initArgs();
    _workerListener();
  }

  void _initStorage() {
    _userId = _initC.localStorage.read(ConstantsKeys.id);

    final data = _initC.localStorage.read(ConstantsKeys.cart);

    if (data is List<ItemModel>) {
      _itemsModal.addAll(data);
      totalItemsCart.value = _itemsModal.length;
    }

    _initC.localStorage.listenKey(
      ConstantsKeys.cart,
      (data) {
        if (data is List<ItemModel>) {
          _itemsModal.addAll(data);
          totalItemsCart.value = data.length;
        }
      },
    );
  }

  void _initArgs() {
    final args = Get.arguments as Map<String, dynamic>;
    dataPart = args['part'];
    modelId = args['modelId'];
    totalPrice.value = dataPart?.price.toInt() ?? 0;
  }

  void _workerListener() {
    debounce(quantity, calculatePricePart);
  }

  CollectionReference<ReviewModel> colReviews() {
    final col = _initC.firestore
        .collection('reviews')
        .doc(dataPart?.id) // partId
        .collection(modelId ?? '') // modelId
        .withConverter(
          fromFirestore: (snapshot, _) =>
              ReviewModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  void calculatePricePart(int quantity) {
    totalPrice.value = quantity * (dataPart?.price.toInt() ?? 0);
  }

  void incQuantity() {
    quantity.value++;
  }

  void decQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }

  void addToCart() async {
    Dialogs.loading(context: Get.context!);

    try {
      final newItemModel = ItemModel(
        partId: dataPart?.id ?? '',
        modelId: modelId ?? '',
        quantity: quantity.value,
        price: dataPart?.price ?? 0,
        description: dataPart?.description ?? '',
      );

      print('newItemModel = ${newItemModel.toJson()}');

      List<ItemModel> items = List.from(_itemsModal);

      print('itemsModal = ${_itemsModal.map((e) => e.toJson()).toList()}');

      // jika itemsModal tidak kosong datanya
      if (items.isNotEmpty) {
        // cek apakah ada itemsModal yang sama partId dengan modelId nya
        final isHasItemModel = items.firstWhereOrNull(
          (element) =>
              element.modelId == newItemModel.modelId &&
              element.partId == newItemModel.partId,
        );

        print('isHasItemModel = ${isHasItemModel != null}');

        // jika sudah ada modelId dan partId yang sama maka update aja quantity-nya dan price-nya
        if (isHasItemModel != null) {
          final totalQuantity = isHasItemModel.quantity + newItemModel.quantity;
          final indexItem = items.indexOf(isHasItemModel);
          print('indexItem = $indexItem');

          items[indexItem] = items[indexItem].copyWith(
            quantity: totalQuantity,
            // price: isHasItemModel.price * totalQuantity,
          );
        } else {
          items.add(newItemModel);
        }
      } else {
        items = [newItemModel];
      }

      print('items = ${items.map((e) => e.toJson()).toList()}');

      await _initC.localStorage.write(ConstantsKeys.cart, items);
      _itemsModal.assignAll(items);
      totalItemsCart.value = items.length;

      Snackbar.success(
        context: Get.context!,
        content: 'Berhasil menambahkan ke keranjang',
      );

      Get.back();
    } catch (e) {
      _initC.logger.e('Erorr: $e');
    }
  }

  void checkout() {
    final orderModel = OrderModel(
      items: [
        ItemModel(
          partId: dataPart?.id ?? '',
          modelId: modelId ?? '',
          quantity: quantity.value,
          price: dataPart?.price ?? 0,
          description: dataPart?.description ?? '',
        ),
      ],
      price: dataPart?.price ?? 0,
      totalPrice: totalPrice.value,
      type: 'request',
      typeStatus: 'pending',
      statusPayment: 'credit',
      userId: _userId ?? '',
    );

    Get.toNamed(Routes.CHECKOUT, arguments: orderModel);
  }

  void moveToCart() => Get.toNamed(Routes.CART);

  void moveToChat() => Get.toNamed(Routes.CHAT);
}
