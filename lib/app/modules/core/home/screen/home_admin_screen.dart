import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/utils/constants_assets.dart';
import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_theme.dart';
import '../controllers/home_controller.dart';

class HomeAdminScreen extends GetView<HomeController> {
  const HomeAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return ListView.separated(
      itemBuilder: (context, index) {
        return _buildListItem(context, index, textTheme);
      },
      itemCount: 10,
      separatorBuilder: (BuildContext context, int index) =>
          const SizedBox(height: 8),
    );
  }

  Widget _buildListItem(BuildContext context, int index, TextTheme textTheme) {
    final isOdd = index.isOdd;
    final status = isOdd
        ? StatusApproval.approved
        : (index == 4 || index == 6)
            ? StatusApproval.rejected
            : StatusApproval.pending;

    return ListTile(
      title: const Text('CLG906F - 40C0441P01'),
      subtitle: Text(
        '${isOdd ? 'Request Barang' : 'Return Barang'} - ${FormatDateTime.dateToString(
          newPattern: 'EEE, dd MMM yyyy',
          value: DateTime.now().toString(),
        )}',
      ),
      titleTextStyle: textTheme.titleSmall,
      subtitleTextStyle: textTheme.bodySmall,
      leading: SvgPicture.asset(
        width: 24,
        isOdd ? ConstantsAssets.icRequestPart : ConstantsAssets.icReturnPart,
      ),
      trailing: _buildState(context, status.name),
      onTap: () => controller.moveToDetailAdmin(status),
    );
  }

  Widget _buildState(BuildContext context, String status) {
    final theme = context.theme;
    final textTheme = context.textTheme;
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
            value: DateTime.now().toString(),
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
