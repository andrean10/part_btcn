import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';

import '../../../../../shared/shared_theme.dart';
import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverList.separated(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
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
                          title: const Text('40C0441P01'),
                          titleTextStyle:
                              textTheme.titleLarge?.copyWith(fontSize: 16),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ENGINE OIL FILTER ELEMENT 机油滤芯 ',
                                style: textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
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
                                  Text(
                                    'x 1',
                                    style: textTheme.labelLarge,
                                  ),
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      itemCount: 2,
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 32),
            itemCount: 3,
          )
        ],
      ),
      persistentFooterButtons: _builderPersistentFooter(textTheme),
    );
  }

  List<Widget> _builderPersistentFooter(TextTheme textTheme) {
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
              trailing: Text(
                TextHelper.formatRupiah(
                  amount: 12000,
                  isCompact: false,
                  isMinus: true,
                ),
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
              subtitle: Text(
                TextHelper.formatRupiah(
                  amount: 236000,
                  isCompact: false,
                ),
              ),
              titleTextStyle: textTheme.bodySmall,
              subtitleTextStyle: textTheme.bodyLarge,
              trailing: FilledButton(
                onPressed: controller.createCheckout,
                child: const Text('Buat Pesanan'),
              ),
            ),
          ],
        ),
      ),
    ];
  }
}
