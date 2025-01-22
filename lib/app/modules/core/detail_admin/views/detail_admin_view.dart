import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:part_btcn/app/data/model/item/item_model.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';
import 'package:part_btcn/app/modules/widgets/textformfield/custom_textform_field.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../../shared/shared_theme.dart';
import '../../../widgets/buttons/buttons.dart';
import '../../../widgets/dialog/dialogs.dart';
import '../controllers/detail_admin_controller.dart';

class DetailAdminView extends GetView<DetailAdminController> {
  const DetailAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
            '${TextHelper.capitalizeEachWords(controller.data?.type)} Barang'),
        centerTitle: true,
      ),
      body: _builderBody(textTheme),
      persistentFooterButtons: _builderPersistentFooter(textTheme),
    );
  }

  Widget _builderBody(TextTheme textTheme) {
    return FirestoreQueryBuilder(
      query: controller.colItems(),
      builder: (context, snapshot, child) {
        if (snapshot.isFetching) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (snapshot.docs.isNotEmpty) {
          final items = snapshot.docs.map((e) => e.data()).toList();

          return GroupedListView(
            elements: items,
            groupBy: (element) => element.modelId,
            groupSeparatorBuilder: (value) => Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                value,
                style: textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: SharedTheme.bold,
                ),
              ),
            ),
            itemBuilder: (context, element) {
              return ListTile(
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
                            style: textTheme.titleLarge?.copyWith(fontSize: 18),
                          ),
                        ),
                        const SizedBox(height: 21),
                        Row(
                          children: [
                            Text(
                              'x ${element.quantity}',
                              style: textTheme.labelLarge,
                            ),
                            const SizedBox(width: 4),
                            Visibility(
                              visible:
                                  controller.data?.typeStatus != 'approved',
                              child: GestureDetector(
                                onTap: () {
                                  Dialogs.alert(
                                    context: context,
                                    title: 'Ubah Jumlah Part',
                                    content: CustomTextFormField(
                                      controller: TextEditingController(),
                                      title: 'Jumlah',
                                      isFilled: false,
                                      keyboardType: TextInputType.number,
                                      onFieldSubmitted: (text) {},
                                    ),
                                    textNo: 'Tutup',
                                    textYes: 'Simpan',
                                  );
                                },
                                child: const Icon(Icons.edit_rounded, size: 16),
                              ),
                            ),
                          ],
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
            Builder(
              builder: (context) {
                if (controller.data?.typeStatus == 'pending') {
                  return CustomTextFormField(
                    controller: controller.discountC,
                    title: 'Diskon',
                    isFilled: false,
                    suffixText: '%',
                    isDense: true,
                  );
                }

                return _buildFooterRow(
                  'Diskon',
                  '${controller.data?.discount ?? 0} %',
                  textTheme,
                );
              },
            ),
            if (controller.data?.voucher?.fee != null)
              _buildFooterRow(
                'Voucher',
                TextHelper.formatRupiah(
                  amount: controller.data?.voucher?.fee,
                  isCompact: false,
                  isMinus: true,
                ),
                textTheme,
              ),
            // const SizedBox(height: 16),
            Obx(
              () {
                return _buildFooterRow(
                  'Total Harga',
                  TextHelper.formatRupiah(
                    amount: controller.totalPrice.value,
                    isCompact: false,
                  ),
                  textTheme,
                  isBold: true,
                );
              },
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Total Harga ',
            //       style: textTheme.titleLarge?.copyWith(
            //         fontWeight: SharedTheme.bold,
            //       ),
            //     ),
            //     ObxValue(
            //       (total) => Text(
            //         TextHelper.formatRupiah(
            //           amount: total.value,
            //           isCompact: false,
            //         ),
            //         style: textTheme.titleLarge?.copyWith(
            //           fontWeight: SharedTheme.bold,
            //         ),
            //       ),
            //       controller.totalPrice,
            //     )
            //   ],
            // ),
            const SizedBox(height: 24),
            Builder(
              builder: (context) {
                return switch (controller.data?.typeStatus) {
                  'pending' => Column(children: [
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
                  'approved' => Container(
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
                  'rejected' => Container(
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
                  _ => const SizedBox.shrink(),
                };
              },
            )
          ],
        ),
      )
    ];
  }

  // List<Widget> _buildPersistentFooter(TextTheme textTheme) {
  //   final data = controller.data;

  //   return [
  //     Container(
  //       padding: const EdgeInsets.all(21),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           _buildFooterRow(
  //               'Harga',
  //               TextHelper.formatRupiah(
  //                 amount: data?.price,
  //                 isCompact: false,
  //               ),
  //               textTheme),
  //           _buildFooterRow(
  //             'Diskon',
  //             '${data?.discount} %',
  //             textTheme,
  //           ),
  //           if (data?.voucher?.fee != null)
  //             _buildFooterRow(
  //               'Voucher',
  //               TextHelper.formatRupiah(
  //                 amount: data?.voucher?.fee,
  //                 isCompact: false,
  //                 isMinus: true,
  //               ),
  //               textTheme,
  //             ),
  //           _buildFooterRow(
  //             'Total Harga',
  //             TextHelper.formatRupiah(
  //               amount: data?.totalPrice,
  //               isCompact: false,
  //             ),
  //             textTheme,
  //             isBold: true,
  //           ),
  //           // jika role finance tampilkan tombol terima aja
  //           Visibility(
  //             visible: controller.mainC.role.value == Role.finance,
  //             child: Container(
  //               margin: const EdgeInsets.only(top: 16),
  //               child: Buttons.filled(
  //                 width: double.infinity,
  //                 onPressed: controller.acceptPayment,
  //                 child: const Text('Terima Pembayaran'),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     )
  //   ];
  // }

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
