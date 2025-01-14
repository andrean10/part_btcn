import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';
import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_theme.dart';
import '../../../widgets/buttons/buttons.dart';
import '../controllers/detail_history_controller.dart';

class DetailHistoryView extends GetView<DetailHistoryController> {
  const DetailHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final orderId = controller.data?.id ?? '';
    final type = _getType(controller.data?.type);
    final status = _getStatus(controller.data?.statusApproval);
    final colorStatus = status == 'Disetujui'
        ? SharedTheme.successColor
        : status == 'Menunggu'
            ? SharedTheme.warningColor
            : SharedTheme.errorColor;
    final methodPayment = _getPaymentMethod(controller.data?.methodPayment);
    final statusPayment = _getPaymentStatus(controller.data?.statusPayment);
    final colorStatusPayment = statusPayment == 'Lunas'
        ? SharedTheme.successColor
        : SharedTheme.warningColor;
    final relativeDateText =
        FormatDateTime.formatRelativeDateText(controller.data?.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Riwayat'),
        centerTitle: false,
        actions: [
          if (controller.data?.statusApproval == StatusApproval.approved)
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
                if (controller.data?.statusPayment == StatusPayment.credit &&
                    controller.data?.methodPayment != MethodPayment.cash)
                  Buttons.text(
                    onPressed: controller.pay,
                    child: const Text('Cara Bayar'),
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
            _buildOrderInfo('Dibuat', relativeDateText, textTheme),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 16),
            Text('Detail Barang', style: textTheme.titleLarge),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final model = controller.data?.models[index];
                return _buildModelItem(context, model, textTheme);
              },
              itemCount: controller.data?.models.length ?? 0,
            ),
          ],
        ),
      ),
      persistentFooterButtons: _buildPersistentFooter(textTheme),
    );
  }

  String _getType(TypeGoods? type) {
    switch (type) {
      case TypeGoods.req:
        return 'Request Barang';
      case TypeGoods.ret:
        return 'Return Barang';
      default:
        return '-';
    }
  }

  String _getStatus(StatusApproval? status) {
    switch (status) {
      case StatusApproval.approved:
        return 'Disetujui';
      case StatusApproval.pending:
        return 'Menunggu';
      case StatusApproval.rejected:
        return 'Ditolak';
      default:
        return '-';
    }
  }

  String _getPaymentMethod(MethodPayment? method) {
    switch (method) {
      case MethodPayment.cash:
        return 'Tunai';
      case MethodPayment.transfer:
        return 'Transfer';
      case MethodPayment.qris:
        return 'QRIS';
      default:
        return '-';
    }
  }

  String _getPaymentStatus(StatusPayment? status) {
    switch (status) {
      case StatusPayment.credit:
        return 'Menunggu';
      case StatusPayment.paid:
        return 'Lunas';
      default:
        return '-';
    }
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

  Widget _buildModelItem(BuildContext context, model, TextTheme textTheme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          model?.id ?? '-',
          style: textTheme.titleLarge?.copyWith(
            fontWeight: SharedTheme.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final part = model?.parts[index];
            return _buildPartItem(context, part, textTheme);
          },
          itemCount: model?.parts.length ?? 0,
        ),
        const Divider(),
      ],
    );
  }

  Widget _buildPartItem(BuildContext context, part, TextTheme textTheme) {
    final id = part?.id ?? '';
    final description = part?.description ?? '';
    final quantity = part?.quantity ?? 0;
    final price = part?.price ?? 0;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      isThreeLine: true,
      title: Text(id),
      titleTextStyle: textTheme.titleLarge?.copyWith(
        fontSize: 16,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(description, style: textTheme.bodyMedium),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  TextHelper.formatRupiah(amount: price, isCompact: false),
                  style: textTheme.titleLarge?.copyWith(fontSize: 18),
                ),
              ),
              const SizedBox(height: 21),
              Text(
                'x $quantity',
                style: textTheme.labelLarge,
              )
            ],
          )
        ],
      ),
    );
  }

  List<Widget> _buildPersistentFooter(TextTheme textTheme) {
    return [
      Container(
        padding: const EdgeInsets.all(21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildFooterRow(
                'Harga',
                TextHelper.formatRupiah(amount: 1050000, isCompact: false),
                textTheme),
            _buildFooterRow('Diskon', '10 %', textTheme),
            _buildFooterRow(
                'Voucher',
                TextHelper.formatRupiah(
                    amount: 10000, isCompact: false, isMinus: true),
                textTheme),
            _buildFooterRow(
              'Total Harga',
              TextHelper.formatRupiah(amount: 890000, isCompact: false),
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
