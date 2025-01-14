import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_theme.dart';
import '../../../../../utils/constants_assets.dart';
import '../../../../helpers/format_date_time.dart';
import '../controllers/history_order_controller.dart';

class HistoryOrderView extends GetView<HistoryOrderController> {
  const HistoryOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          final history = controller.initC.dummyHistory[index];

          final typeGood = switch (history.type) {
            TypeGoods.req => ('Request', ConstantsAssets.icRequestPart),
            TypeGoods.ret => ('Return', ConstantsAssets.icReturnPart)
          };
          final statusPayment = switch (history.statusPayment) {
            StatusPayment.paid => ('Lunas', SharedTheme.successColor),
            StatusPayment.credit => ('Menunggu', SharedTheme.warningColor),
            _ => null
          };
          final methodPayment = switch (history.methodPayment) {
            MethodPayment.cash => 'COD',
            MethodPayment.transfer => 'Transfer',
            MethodPayment.qris => 'QRIS',
            _ => null
          };
          final statusApproval = switch (history.statusApproval) {
            StatusApproval.approved => ('Disetujui', SharedTheme.successColor),
            StatusApproval.pending => ('Menunggu', SharedTheme.warningColor),
            StatusApproval.rejected => ('Ditolak', SharedTheme.errorColor),
          };
          final relativeDateText =
              FormatDateTime.formatRelativeDateText(history.createdAt);

          return ListTile(
            title: Text('No Order : ${history.id}'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Dibuat : $relativeDateText'),
                const SizedBox(height: 6),
                _builderState(
                  context: context,
                  title: 'Tipe',
                  typeGood: typeGood,
                  statusApproval: statusApproval,
                ),
                if (methodPayment != null && statusPayment != null)
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    child: _builderState(
                      context: context,
                      title: 'Pembayaran',
                      methodPayment: methodPayment,
                      statusPayment: statusPayment,
                    ),
                  ),
                if (history.statusApproval == StatusApproval.approved)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: GestureDetector(
                      onTap: () => controller.showModalReview(index),
                      child: const Text('Tuliskan review'),
                    ),
                  ),
              ],
            ),
            titleTextStyle: textTheme.titleSmall,
            leading: SvgPicture.asset(width: 24, typeGood.$2),
            isThreeLine: true,
            onTap: () => controller.onTap(history),
          );
        },
        itemCount: controller.initC.dummyHistory.length,
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
    );
  }

  Widget _builderState({
    required BuildContext context,
    required String title,
    (String, String)? typeGood,
    (String, Color)? statusApproval,
    String? methodPayment,
    (String, Color?)? statusPayment,
  }) {
    final textTheme = context.textTheme;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                title,
                style: textTheme.labelLarge
                    ?.copyWith(fontWeight: SharedTheme.bold),
              ),
            ),
            Expanded(
              child: Text(
                'Status',
                style: textTheme.labelLarge
                    ?.copyWith(fontWeight: SharedTheme.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Builder(builder: (context) {
                String text = '';

                if (typeGood != null) {
                  text = '${typeGood.$1} Barang';
                }

                if (methodPayment != null) {
                  text = methodPayment;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(text),
                );
              }),
            ),
            Expanded(
              child: Builder(builder: (context) {
                String text = '';
                Color? color;

                if (statusApproval != null) {
                  text = statusApproval.$1;
                  color = statusApproval.$2;
                }

                if (statusPayment != null) {
                  text = statusPayment.$1;
                  color = statusPayment.$2;
                }

                return Center(
                  child: _builderContainerState(
                    context: context,
                    text: text,
                    color: color,
                  ),
                );
              }),
            ),
          ],
        ),
      ],
    );
  }

  Widget _builderContainerState({
    required BuildContext context,
    required String text,
    required Color? color,
  }) {
    final theme = context.theme;
    final textTheme = context.textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            text,
            style: textTheme.labelSmall
                ?.copyWith(color: theme.colorScheme.surface),
          ),
        ),
      ],
    );
  }
}
