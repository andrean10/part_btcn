import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';
import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_method.dart';
import '../../../../../shared/shared_theme.dart';
import '../../../widgets/buttons/buttons.dart';
import '../controllers/detail_history_controller.dart';

class DetailHistoryView extends GetView<DetailHistoryController> {
  const DetailHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final orderId = controller.data?.id ?? '';
    final type = getType(controller.data?.type);
    final status = getStatus(controller.data?.typeStatus);
    final colorStatus = status == 'Disetujui'
        ? SharedTheme.successColor
        : status == 'Menunggu'
            ? SharedTheme.warningColor
            : SharedTheme.errorColor;
    final methodPayment = getPaymentMethod(controller.data?.typePayment);
    final statusPayment = getPaymentStatus(controller.data?.statusPayment);
    final colorStatusPayment = statusPayment == 'Lunas'
        ? SharedTheme.successColor
        : SharedTheme.warningColor;

    final formatDateTime = FormatDateTime.dateToString(
      newPattern: 'EEEE, dd MMMM yyyy, HH: mm',
      value: controller.data?.createdAt?.toIso8601String(),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat'),
        centerTitle: false,
        actions: [
          if (controller.data?.statusPayment == 'paid' &&
              controller.role == 'user')
            Buttons.text(
              onPressed: controller.generateInvoice,
              child: const Text('Invoice'),
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildOrderInfo('No Order', orderId, textTheme),
            const SizedBox(height: 12),
            _buildOrderInfo('Tipe', type, textTheme),
            const SizedBox(height: 12),
            _buildOrderInfo('Status Approval', status, textTheme, colorStatus),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildOrderInfo('Metode Pembayaran', methodPayment, textTheme),
                const Spacer(),
                Visibility(
                  visible: controller.data?.statusPayment == 'credit' &&
                      controller.data?.typePayment != 'cash' &&
                      controller.data?.typeStatus == 'approved',
                  child: Buttons.text(
                    onPressed: controller.pay,
                    child: const Text('Cara Bayar'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            _buildOrderInfo(
              'Status Pembayaran',
              statusPayment,
              textTheme,
              colorStatusPayment,
            ),
            const SizedBox(height: 12),
            _buildOrderInfo('Dibuat', formatDateTime, textTheme),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 16),
            Text('Detail Barang', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            FirestoreQueryBuilder(
              query: controller.colItems(),
              builder: (context, snapshot, child) {
                if (snapshot.isFetching) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                }

                if (snapshot.docs.isNotEmpty) {
                  final items = snapshot.docs.map((e) => e.data()).toList();
                  controller.data = controller.data?.copyWith(items: items);

                  return GroupedListView(
                    shrinkWrap: true,
                    elements: items,
                    groupBy: (element) => element.modelId,
                    groupSeparatorBuilder: (value) => Text(
                      value,
                      style: textTheme.titleLarge?.copyWith(
                        fontSize: 18,
                        fontWeight: SharedTheme.bold,
                      ),
                    ),
                    itemBuilder: (context, element) {
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        isThreeLine: true,
                        title: Text(element.partId),
                        titleTextStyle: textTheme.titleLarge?.copyWith(
                          fontSize: 16,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              element.description,
                              style: textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    TextHelper.formatRupiah(
                                      amount: element.price,
                                      isCompact: false,
                                    ),
                                    style: textTheme.titleLarge
                                        ?.copyWith(fontSize: 18),
                                  ),
                                ),
                                const SizedBox(height: 21),
                                Text(
                                  'x ${element.quantity}',
                                  style: textTheme.labelLarge,
                                ),
                              ],
                            )
                          ],
                        ),
                      );
                    },
                  );
                }

                return const Center(child: Text('Data barang tidak ditemukan'));
              },
            ),

            // ListView.builder(
            //   shrinkWrap: true,
            //   physics: const NeverScrollableScrollPhysics(),
            //   padding: EdgeInsets.zero,
            //   itemBuilder: (context, index) {
            //     final model = controller.data?.items?[index];
            //     return _buildModelItem(context, model, textTheme);
            //   },
            //   itemCount: controller.data?.items?.length ?? 0,
            // ),
          ],
        ),
      ),
      persistentFooterButtons: _buildPersistentFooter(textTheme),
    );
  }

  Widget _buildOrderInfo(
    String label,
    String value,
    TextTheme textTheme, [
    Color? color,
  ]) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Text(
          value,
          style: textTheme.titleLarge?.copyWith(
            fontWeight: SharedTheme.bold,
            fontSize: 18,
            color: color,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildPersistentFooter(TextTheme textTheme) {
    final data = controller.data;

    return [
      Container(
        padding: const EdgeInsets.all(21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFooterRow(
                'Harga',
                TextHelper.formatRupiah(
                  amount: data?.price,
                  isCompact: false,
                ),
                textTheme),
            _buildFooterRow(
              'Diskon',
              '${data?.discount ?? 0} %',
              textTheme,
            ),
            if (data?.voucher?.fee != null)
              _buildFooterRow(
                'Voucher',
                TextHelper.formatRupiah(
                  amount: data?.voucher?.fee,
                  isCompact: false,
                  isMinus: true,
                ),
                textTheme,
              ),
            _buildFooterRow(
              'Total Harga',
              TextHelper.formatRupiah(
                amount: data?.totalPrice,
                isCompact: false,
              ),
              textTheme,
              isBold: true,
            ),
            // jika role finance tampilkan tombol terima aja
            Visibility(
              visible: controller.mainC.role.value == Role.finance,
              child: Container(
                margin: const EdgeInsets.only(top: 16),
                child: Buttons.filled(
                  width: double.infinity,
                  onPressed: controller.acceptPayment,
                  child: const Text('Terima Pembayaran'),
                ),
              ),
            ),
          ],
        ),
      )
    ];
  }

  Widget _buildFooterRow(String label, String value, TextTheme textTheme,
      {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        FittedBox(
          child: Text(
            label,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: isBold ? SharedTheme.bold : FontWeight.normal,
            ),
          ),
        ),
        FittedBox(
          child: Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              fontWeight: isBold ? SharedTheme.bold : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
