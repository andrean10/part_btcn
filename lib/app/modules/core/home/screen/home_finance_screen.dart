import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/db/history/order_db.dart';
import 'package:part_btcn/app/modules/core/home/controllers/home_controller.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_theme.dart';
import '../../../../helpers/format_date_time.dart';

class HomeFinanceScreen extends GetView<HomeController> {
  const HomeFinanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    final dummyHistoryFilterRequest = controller.initC.dummyHistory
        .where((element) =>
            element.type == TypeGoods.req &&
            element.statusApproval == StatusApproval.approved)
        .toList();

    return ListView.separated(
      itemBuilder: (context, index) {
        final history = dummyHistoryFilterRequest[index];
        return _buildListItem(
          context: context,
          index: index,
          history: history,
          textTheme: textTheme,
        );
      },
      itemCount: dummyHistoryFilterRequest.length,
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  Widget _buildListItem({
    required BuildContext context,
    required int index,
    required OrderDB history,
    required TextTheme textTheme,
  }) {
    final typeGood = controller.getTypeGood(history.type);

    final statusPayment = controller.getStatusPayment(history.statusPayment);
    final methodPayment = controller.getMethodPayment(history.methodPayment);
    final statusApproval = controller.getStatusApproval(history.statusApproval);
    final relativeDateText =
        FormatDateTime.formatRelativeDateText(history.createdAt);

    return ListTile(
      title: Text('No Order : ${history.id}'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Dibuat : $relativeDateText'),
          const SizedBox(height: 6),
          _buildState(
            context: context,
            title: 'Tipe',
            typeGood: typeGood,
            statusApproval: statusApproval,
          ),
          if (methodPayment != null && statusPayment != null)
            Container(
              margin: const EdgeInsets.only(top: 6),
              child: _buildState(
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
      onTap: () => controller.moveToDetailFinance(history),
    );
  }

  Widget _buildState({
    required BuildContext context,
    required String title,
    (String, String)? typeGood,
    (String, Color)? statusApproval,
    String? methodPayment,
    (String?, Color?)? statusPayment,
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
                  text = statusPayment.$1!;
                  color = statusPayment.$2;
                }

                return Center(
                  child: _buildContainerState(
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

  Widget _buildContainerState({
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
