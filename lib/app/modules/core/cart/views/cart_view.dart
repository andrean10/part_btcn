import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../shared/shared_theme.dart';
import '../../../widgets/buttons/buttons.dart';
import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Barang'),
        centerTitle: true,
      ),
      persistentFooterButtons: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Buttons.filled(
            width: double.infinity,
            onPressed: controller.moveToCheckout,
            child: const Text('Checkout'),
          ),
        )
      ],
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
    );
  }
}
