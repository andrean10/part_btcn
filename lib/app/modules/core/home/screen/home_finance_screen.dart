import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/home/controllers/home_controller.dart';

import '../../../../../shared/shared_theme.dart';
import '../../../../../utils/constants_assets.dart';
import '../../../../helpers/format_date_time.dart';

class HomeFinanceScreen extends GetView<HomeController> {
  const HomeFinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return FirestoreListView.separated(
      query: controller
          .colOrder()
          .where(FieldPath.fromString('typeStatus'), isNotEqualTo: 'rejected')
          .orderBy(FieldPath.fromString('createdAt'), descending: true),
      itemBuilder: (context, doc) {
        final order = doc.data();

        final typeGood = switch (order.type) {
          'request' => ('Request', ConstantsAssets.icRequestPart),
          'return' => ('Return', ConstantsAssets.icReturnPart),
          _ => ('', '')
        };

        final statusApproval = switch (order.typeStatus) {
          'approved' => ('Disetujui', SharedTheme.successColor),
          'pending' => ('Menunggu', SharedTheme.warningColor),
          'rejected' => ('Ditolak', SharedTheme.errorColor),
          _ => ('', Colors.black)
        };

        final methodPayment = switch (order.typePayment) {
          'cash' => 'COD',
          'transfer' => 'Transfer',
          'qris' => 'QRIS',
          _ => null
        };

        final statusPayment = switch (order.statusPayment) {
          'paid' => ('Lunas', SharedTheme.successColor),
          'credit' => ('Menunggu', SharedTheme.warningColor),
          _ => null
        };

        final formatDateTime = FormatDateTime.dateToString(
          newPattern: 'EEEE, dd MMMM yyyy, HH: mm',
          value: order.createdAt?.toIso8601String(),
        );

        return ListTile(
          title: Text('No Order : ${order.id}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dibuat : $formatDateTime'),
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
            ],
          ),
          titleTextStyle: textTheme.titleSmall,
          leading: SvgPicture.asset(width: 24, typeGood.$2),
          isThreeLine: true,
          onTap: () => controller.moveToDetailFinance(order),
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
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
