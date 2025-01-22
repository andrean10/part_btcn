import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/utils/constants_assets.dart';
import '../../../../../shared/shared_theme.dart';
import '../controllers/home_controller.dart';

class HomeAdminScreen extends GetView<HomeController> {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return FirestoreListView.separated(
      query: controller
          .colOrder()
          .orderBy(FieldPath.fromString('createdAt'), descending: true),
      itemBuilder: (context, doc) {
        final data = doc.data();
        return _buildListItem(context, textTheme, data);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }

  Widget _buildListItem(
    BuildContext context,
    TextTheme textTheme,
    OrderModel data,
  ) {
    final isRequest = data.type == 'request';

    return ListTile(
      title: Text('No Order: ${data.id}'),
      subtitle: Text(
        '${isRequest ? 'Request Barang' : 'Return Barang'} - ${FormatDateTime.dateToString(
          newPattern: 'EEE, dd MMM yyyy',
          value: data.createdAt.toString(),
        )}',
      ),
      titleTextStyle: textTheme.titleSmall,
      subtitleTextStyle: textTheme.bodySmall,
      leading: SvgPicture.asset(
        width: 24,
        isRequest
            ? ConstantsAssets.icRequestPart
            : ConstantsAssets.icReturnPart,
      ),
      trailing: _buildState(context, data),
      onTap: () => controller.moveToDetailAdmin(data),
    );
  }

  Widget _buildState(BuildContext context, OrderModel data) {
    final theme = context.theme;
    final textTheme = context.textTheme;
    final status = data.typeStatus;
    Color? color;

    switch (status) {
      case 'approved':
        color = SharedTheme.successColor;
        break;
      case 'pending':
        color = SharedTheme.warningColor;
        break;
      case 'rejected':
        color = theme.colorScheme.error;
        break;
      default:
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          FormatDateTime.dateToString(
            newPattern: 'HH:mm',
            value: data.createdAt.toString(),
          ),
          style: textTheme.labelSmall,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            status.capitalizeFirst ?? '-',
            style: textTheme.labelSmall
                ?.copyWith(color: theme.colorScheme.surface),
          ),
        ),
      ],
    );
  }
}
