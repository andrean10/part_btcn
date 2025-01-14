import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/modules/widgets/textformfield/custom_textform_field.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_theme.dart';
import '../../../widgets/buttons/buttons.dart';
import '../controllers/detail_admin_controller.dart';

class DetailAdminView extends GetView<DetailAdminController> {
  const DetailAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final size = context.mediaQuerySize;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Request Barang'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'CLG906F',
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
                  return ListTile(
                    contentPadding: EdgeInsets.zero,
                    isThreeLine: true,
                    title: Text(
                      '40C0441P01',
                    ),
                    titleTextStyle: textTheme.titleLarge?.copyWith(
                      fontSize: 16,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ENGINE OIL FILTER ELEMENT 机油滤芯 ',
                          style: textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Rp. 236.600',
                                style: textTheme.titleLarge
                                    ?.copyWith(fontSize: 18),
                              ),
                            ),
                            const SizedBox(height: 21),
                            Obx(
                              () {
                                if (controller.status.value ==
                                    StatusApproval.pending) {
                                  return SizedBox(
                                    width: size.width * 0.2,
                                    child: CustomTextFormField(
                                      controller: controller.quantityC,
                                      keyboardType: TextInputType.number,
                                      title: '',
                                      maxLines: 1,
                                      isFilled: false,
                                      isDense: true,
                                      isNumericOnly: true,
                                    ),
                                  );
                                }

                                return Text(
                                  'x 1',
                                  style: textTheme.labelLarge,
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
                itemCount: 3,
              ),
              const Divider(),
            ],
          );
        },
        // separatorBuilder: (context, index) => const Divider(),
        itemCount: 2,
      ),
      // bottomSheet: _builderBottomSheet(textTheme),
      persistentFooterButtons: _builderPersistentFooter(textTheme),
    );
  }

  List<Widget> _builderPersistentFooter(TextTheme textTheme) {
    return [
      Container(
        padding: const EdgeInsets.all(21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () {
                if (controller.status.value == StatusApproval.pending) {
                  return CustomTextFormField(
                    controller: controller.discountC,
                    title: 'Diskon',
                    isFilled: false,
                    suffixText: '%',
                  );
                }

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Diskon',
                      style: textTheme.bodyLarge,
                    ),
                    Text(
                      '10 %',
                      style: textTheme.bodyLarge,
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Total Harga ',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: SharedTheme.bold,
                  ),
                ),
                AutoSizeText(
                  'Rp. 236.000',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: SharedTheme.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 21),
            Obx(
              () {
                return switch (controller.status.value) {
                  StatusApproval.pending => Column(children: [
                      Buttons.filled(
                        width: double.infinity,
                        onPressed: () =>
                            controller.changeStatus(StatusApproval.approved),
                        child: const Text('Setujui'),
                      ),
                      const SizedBox(height: 8),
                      Buttons.text(
                        width: double.infinity,
                        onPressed: () =>
                            controller.changeStatus(StatusApproval.rejected),
                        child: const Text('Tolak'),
                      ),
                    ]),
                  StatusApproval.approved => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: SharedTheme.successColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Data ini telah di disetujui',
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  StatusApproval.rejected => Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: SharedTheme.errorColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        'Data ini telah di ditolak',
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ),
                };
              },
            )
          ],
        ),
      )
    ];
  }
}
