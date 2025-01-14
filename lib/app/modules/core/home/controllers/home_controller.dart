import 'dart:io';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/db/history/order_db.dart';
import 'package:part_btcn/app/data/model/data/data_model.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';
import 'package:part_btcn/app/modules/core/main/controllers/main_controller.dart';
import 'package:part_btcn/app/modules/widgets/snackbar/snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_theme.dart';
import '../../../../../utils/constants_assets.dart';
import '../../../../routes/app_pages.dart';

class HomeController extends GetxController with StateMixin<List<DataModel>> {
  late final InitController initC;
  late final MainController mainC;

  final categoryIndex = 0.obs;
  final modelId = RxnString();

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

    fetchColModels();
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

  CollectionReference<DataModel> colModels({String? modelId}) {
    final col = initC.firestore.collection('models').withConverter(
          fromFirestore: (snapshot, _) => DataModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );

    if (modelId != null) {
      col.where(FieldPath.documentId, isEqualTo: modelId);
    }

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

  void setCategory(String id) => modelId.value = id;

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
    sheet.getRangeByName('I1').setText('Grand Total');

    // filter berdasarkan statusPayment approved dan statusApproval approved
    final data = initC.dummyHistory
        .where(
          (element) =>
              element.type == TypeGoods.req &&
              element.statusApproval == StatusApproval.approved &&
              element.statusPayment == StatusPayment.paid,
        )
        .toList();
    // isi body di sheet
    for (var i = 0; i < data.length; i++) {
      final dataItem = data[i];
      final invoiceDate = FormatDateTime.dateToString(
        newPattern: 'dd-MMM-yyyy',
        value: dataItem.createdAt.toString(),
      );

      for (var j = 0; j < dataItem.models.length; j++) {
        final model = dataItem.models[j];

        for (var k = 0; k < model.parts.length; k++) {
          final part = model.parts[k];
          final subTotal = part.quantity * part.price;
          final discount = subTotal * 0.1;
          final grandTotal = subTotal - discount;

          sheet.getRangeByName('A${k + 2}').setText(dataItem.id);
          sheet.getRangeByName('B${k + 2}').setText(invoiceDate);
          sheet.getRangeByName('C${k + 2}').setText('PT ANGKASA PURA');
          sheet.getRangeByName('D${k + 2}').setText(part.description);
          sheet
              .getRangeByName('E${k + 2}')
              .setNumber((part.quantity).toDouble());
          sheet.getRangeByName('F${k + 2}').setNumber(part.price.toDouble());
          sheet.getRangeByName('G${k + 2}').setNumber(subTotal.toDouble());
          sheet.getRangeByName('H${k + 2}').setNumber(discount);
          sheet.getRangeByName('I${k + 2}').setNumber(grandTotal);
        }
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
        final file = File('$path/Report${FormatDateTime.dateToString(
          newPattern: 'yyyy_MM_dd',
          value: DateTime.now().toString(),
        )}.xlsx');
        await file.writeAsBytes(bytes.toList());
      } else {
        // tulis filenya ke folder tersebut
        final file = File('$path/Report${FormatDateTime.dateToString(
          newPattern: 'yyyy_MM_dd_HH_mm_ss',
          value: DateTime.now().toString(),
        )}.xlsx');
        await file.writeAsBytes(bytes.toList());
      }

      Snackbar.success(
        context: Get.context!,
        content:
            'Berhasil menarik data laporan file tersimpan di folder BTCN > reports',
      );
      workbook.dispose();
    }
  }

  // ADMIN
  void moveToDetailAdmin(StatusApproval status) {
    Get.toNamed(Routes.DETAIL_ADMIN, arguments: status);
  }

  // FINANCE
  void moveToDetailFinance(OrderDB history) {
    Get.toNamed(Routes.DETAIL_HISTORY, arguments: history);
  }

  // USER
  void moveToCart() => Get.toNamed(Routes.CART);

  void moveToChat() => Get.toNamed(Routes.CHAT, arguments: mainC.role.value);

  void showDetailPart() => Get.toNamed(Routes.DETAIL_PART);
}
