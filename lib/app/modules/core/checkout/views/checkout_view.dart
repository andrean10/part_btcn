import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/item/item_model.dart';
import 'package:part_btcn/app/data/model/order/order_model.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';
import 'package:grouped_list/grouped_list.dart';

import '../../../../../shared/shared_theme.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final order = controller.order;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: order != null
          ? GroupedListView(
              elements: order.items ?? <ItemModel>[],
              groupBy: (item) => item.modelId,
              groupSeparatorBuilder: (String modelId) => Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  modelId,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: SharedTheme.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              itemBuilder: (context, item) {
                return Column(
                  children: [
                    ListTile(
                      isThreeLine: true,
                      title: Text(item.partId),
                      titleTextStyle:
                          textTheme.titleLarge?.copyWith(fontSize: 16),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.description,
                            style: textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 2),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  TextHelper.formatRupiah(
                                    amount: item.price,
                                    isCompact: false,
                                  ),
                                  style: textTheme.labelLarge,
                                ),
                              ),
                              const SizedBox(height: 21),
                              Text(
                                'x ${item.quantity}',
                                style: textTheme.labelLarge,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total',
                                style: textTheme.titleMedium
                                    ?.copyWith(fontWeight: SharedTheme.bold),
                              ),
                              Text(
                                TextHelper.formatRupiah(
                                    amount: item.price * item.quantity,
                                    isCompact: false),
                                style: textTheme.titleMedium
                                    ?.copyWith(fontWeight: SharedTheme.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 14),
                  ],
                );
              },
            )
          : const Center(child: Text('No items available')),
      persistentFooterButtons: _builderPersistentFooter(textTheme, order),
    );
  }

  List<Widget> _builderPersistentFooter(
    TextTheme textTheme,
    OrderModel? order,
  ) {
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              visualDensity: VisualDensity.compact,
              leading: const Icon(
                Icons.loyalty_rounded,
                size: 21,
              ),
              title: const Text('Voucher Toko'),
              titleTextStyle: textTheme.labelLarge,
              trailing: ObxValue(
                (voucher) => Text(
                  TextHelper.formatRupiah(
                    amount: voucher.value?.fee,
                    isCompact: false,
                    isMinus: true,
                  ),
                ),
                controller.voucher,
              ),
              leadingAndTrailingTextStyle: textTheme.labelLarge,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              dense: true,
              leading: const Icon(
                Icons.payment_rounded,
                size: 21,
              ),
              title: const Text('Metode Pembayaran'),
              titleTextStyle: textTheme.labelLarge,
              trailing: Obx(
                () => Text(
                  controller.methodPaymentName.value ?? 'Pilih Metode',
                ),
              ),
              leadingAndTrailingTextStyle: textTheme.labelLarge,
              onTap: controller.showModalMethodPayments,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity.compact,
              title: const Text('Total Pembayaran'),
              subtitle: ObxValue(
                  (totalPrice) => Text(
                        TextHelper.formatRupiah(
                          amount: totalPrice.value,
                          isCompact: false,
                        ),
                      ),
                  controller.totalPrice),
              titleTextStyle: textTheme.bodySmall,
              subtitleTextStyle: textTheme.bodyLarge,
              trailing: ObxValue(
                  (method) => FilledButton(
                        onPressed: method.value != null
                            ? controller.createCheckout
                            : null,
                        child: const Text('Buat Pesanan'),
                      ),
                  controller.methodPayment),
            ),
          ],
        ),
      ),
    ];
  }
}
