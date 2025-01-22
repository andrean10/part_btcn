import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/db/history/order_db.dart';
import 'package:part_btcn/app/data/model/data/data_model.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/app/data/model/parts/part_model.dart';
import 'package:part_btcn/app/data/model/user/users_model.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';
import 'package:part_btcn/app/modules/core/main/controllers/main_controller.dart';
import 'package:part_btcn/app/modules/widgets/snackbar/snackbar.dart';
import 'package:part_btcn/utils/constants_keys.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_theme.dart';
import '../../../../../utils/constants_assets.dart';
import '../../../../data/model/item/item_model.dart';
import '../../../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<List<DataModel>> {
  late final InitController initC;
  late final MainController mainC;

  String userId = '';
  String? userRole;

  final totalItemsCart = 0.obs;
  final categoryIndex = 0.obs;
  final modelId = RxnString();
  List<DataModel>? models;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }

    if (Get.isRegistered<MainController>()) {
      mainC = Get.find<MainController>();
    }

    _initStorage();
    fetchColModels();
  }

  void _initStorage() {
    final data = initC.localStorage.read(ConstantsKeys.cart);
    userId = initC.localStorage.read(ConstantsKeys.id);
    userRole = initC.localStorage.read(ConstantsKeys.role);

    if (data is List<ItemModel>) {
      totalItemsCart.value = data.length;
    }

    initC.localStorage.listenKey(
      ConstantsKeys.cart,
      (data) {
        if (data is List<ItemModel>) {
          totalItemsCart.value = data.length;
        }
      },
    );
  }

  Future<void> fetchColModels() async {
    change(null, status: RxStatus.loading());

    try {
      final data = await colModels().get();

      if (data.size != 0) {
        final docsData = data.docs.map((e) => e.data()).toList();
        modelId.value = docsData.first.id;

        change(docsData, status: RxStatus.success());
      } else {
        change(null, status: RxStatus.empty());
      }
    } on FirebaseException catch (e) {
      initC.logger.e('Error: $e');
      change(null, status: RxStatus.error(e.message));
    }
  }

  CollectionReference<DataModel> colModels(
      // {String? modelId}
      ) {
    final col = initC.firestore.collection('models').withConverter(
          fromFirestore: (snapshot, _) => DataModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    // if (modelId != null) {
    //   col.where(FieldPath.documentId, isEqualTo: modelId);
    // }

    return col;
  }

  CollectionReference<PartModel> colParts() {
    final col = initC.firestore.collection('parts').withConverter(
          fromFirestore: (snapshot, _) => PartModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  CollectionReference<OrderModel> colOrder() {
    final col = initC.firestore.collection('order').withConverter(
          fromFirestore: (snapshot, _) => OrderModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  (String, String) getTypeGood(TypeGoods type) {
    switch (type) {
      case TypeGoods.req:
        return ('Request', ConstantsAssets.icRequestPart);
      case TypeGoods.ret:
        return ('Return', ConstantsAssets.icReturnPart);
    }
  }

  (String, Color)? getStatusPayment(StatusPayment? status) {
    switch (status) {
      case StatusPayment.paid:
        return ('Lunas', SharedTheme.successColor);
      case StatusPayment.credit:
        return ('Menunggu', SharedTheme.warningColor);
      default:
        return null;
    }
  }

  String? getMethodPayment(MethodPayment? method) {
    switch (method) {
      case MethodPayment.cash:
        return 'COD';
      case MethodPayment.transfer:
        return 'Transfer';
      case MethodPayment.qris:
        return 'QRIS';
      default:
        return null;
    }
  }

  (String, Color) getStatusApproval(StatusApproval status) {
    switch (status) {
      case StatusApproval.approved:
        return ('Disetujui', SharedTheme.successColor);
      case StatusApproval.pending:
        return ('Menunggu', SharedTheme.warningColor);
      case StatusApproval.rejected:
        return ('Ditolak', SharedTheme.errorColor);
    }
  }

  void setCategory({required int index, required String id}) {
    categoryIndex.value = index;
    modelId.value = id;
  }

  Future<void> pullDataReport() async {
    final workbook = Workbook();
    final sheet = workbook.worksheets[0];

    // buat header dengan teksnya bold
    final headerStyle = workbook.styles.add('HeaderStyle');
    headerStyle.bold = true;
    final headerRange = sheet.getRangeByName('A1:I1');
    headerRange.cellStyle = headerStyle;

    // isi header
    sheet.getRangeByName('A1').setText('No Order');
    sheet.getRangeByName('B1').setText('Tanggal Invoice');
    sheet.getRangeByName('C1').setText('Customer');
    sheet.getRangeByName('D1').setText('Nama Barang');
    sheet.getRangeByName('E1').setText('Qty');
    sheet.getRangeByName('F1').setText('Harga Satuan');
    sheet.getRangeByName('G1').setText('Sub Total');
    sheet.getRangeByName('H1').setText('Diskon');
    sheet.getRangeByName('I1').setText('Voucher');
    sheet.getRangeByName('J1').setText('Grand Total');

    try {
      final snapshotOrders = await colOrder()
          .where(FieldPath.fromString('typeStatus'), isNotEqualTo: 'rejected')
          .where(FieldPath.fromString('statusPayment'), isEqualTo: 'paid')
          .orderBy(FieldPath.fromString('createdAt'), descending: true)
          .get();

      final orders = snapshotOrders.docs.map((e) => e.data()).toList();

      int rowIndex = 2; // Start from the second row

      // isi body di sheet
      for (var order in orders) {
        final snapshotUser = await initC.firestore
            .collection('users')
            .doc(order.userId)
            .withConverter(
              fromFirestore: (snapshot, _) =>
                  UsersModel.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson(),
            )
            .get();

        final snapshotItems = await colOrder()
            .doc(order.id)
            .collection('items')
            .withConverter(
              fromFirestore: (snapshot, _) =>
                  ItemModel.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson(),
            )
            .get();

        final items = snapshotItems.docs.map((e) => e.data()).toList();

        final orderId = order.id ?? '-';
        final name = snapshotUser.data()?.name ?? '-';
        final invoiceDate = FormatDateTime.dateToString(
          newPattern: 'dd-MMM-yyyy',
          value: order.createdAt.toString(),
        );
        final discount = order.discount ?? 0;
        final voucher = order.voucher?.fee;

        for (var item in items) {
          final description = item.description;
          final quantity = item.quantity;
          final price = item.price;
          final subTotal = price * quantity;
          final grandTotal = order.totalPrice;

          sheet.getRangeByName('A$rowIndex').setText(orderId);
          sheet.getRangeByName('B$rowIndex').setText(invoiceDate);
          sheet.getRangeByName('C$rowIndex').setText(name);
          sheet.getRangeByName('D$rowIndex').setText(description);
          sheet.getRangeByName('E$rowIndex').setNumber(quantity.toDouble());
          sheet.getRangeByName('F$rowIndex').setText(
                TextHelper.formatRupiah(
                  amount: price,
                  isCompact: false,
                ),
              );
          sheet.getRangeByName('G$rowIndex').setText(
                TextHelper.formatRupiah(
                  amount: subTotal,
                  isCompact: false,
                ),
              );
          sheet.getRangeByName('H$rowIndex').setText('$discount %');
          sheet.getRangeByName('I$rowIndex').setText(
                TextHelper.formatRupiah(
                  amount: voucher,
                  isCompact: false,
                  isMinus: true,
                ),
              );
          sheet.getRangeByName('J$rowIndex').setText(
                TextHelper.formatRupiah(
                  amount: grandTotal,
                  isCompact: false,
                ),
              );

          rowIndex++;
        }
      }

      // save
      final bytes = workbook.saveAsStream();

      if (await Permission.manageExternalStorage.request().isGranted) {
        // simpan ke penyimpanan hp di folder download
        final directory = Directory('/storage/emulated/0/BTCN/reports');
        final path = directory.path;

        if (!directory.existsSync()) {
          await directory.create(recursive: true);
        }

        final file = File('$path/Report_${FormatDateTime.dateToString(
          newPattern: 'yyyy_MM_dd_HH_mm_ss',
          value: DateTime.now().toString(),
        )}.xlsx');
        await file.writeAsBytes(bytes.toList());

        Snackbar.success(
          context: Get.context!,
          content:
              'Berhasil menarik data laporan file tersimpan di folder BTCN > reports',
        );
        workbook.dispose();
      }
    } on FirebaseException catch (e) {
      initC.logger.e('Error: code = ${e.code}\n${e.message}');
    }
  }

  // ADMIN
  void moveToDetailAdmin(OrderModel data) {
    Get.toNamed(Routes.DETAIL_ADMIN, arguments: data);
  }

  // FINANCE
  void moveToDetailFinance(OrderModel order) {
    Get.toNamed(Routes.DETAIL_HISTORY, arguments: order);
  }

  // USER
  void moveToCart() => Get.toNamed(Routes.CART);

  void moveToChat() => Get.toNamed(
        Routes.DETAIL_CHAT,
        arguments: mainC.role.value,
      );

  void moveToDetailPart(PartModel part) => Get.toNamed(
        Routes.DETAIL_PART,
        arguments: {
          'part': part,
          'modelId': modelId.value,
        },
      );
}
