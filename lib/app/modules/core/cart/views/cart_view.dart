import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/item/item_model.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';

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
          child: Column(
            children: [
              Buttons.filled(
                width: double.infinity,
                onPressed: controller.moveToCheckout,
                child: const Text('Checkout'),
              ),
              const SizedBox(height: 8),
              Buttons.text(
                width: double.infinity,
                onPressed: controller.clearItems,
                child: const Text('Hapus Semua Item'),
              ),
            ],
          ),
        ),
      ],
      body: Obx(
        () => controller.items.isNotEmpty
            ? GroupedListView(
                elements: controller.items.value,
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
                  return Slidable(
                    key: ValueKey(item.partId),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) => controller.deleteItem(item),
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: 'Delete',
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 16),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Total',
                                    style: textTheme.titleMedium?.copyWith(
                                        fontWeight: SharedTheme.bold),
                                  ),
                                  Text(
                                    TextHelper.formatRupiah(
                                        amount: item.price * item.quantity,
                                        isCompact: false),
                                    style: textTheme.titleMedium?.copyWith(
                                        fontWeight: SharedTheme.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const Divider(height: 14),
                      ],
                    ),
                  );
                },
              )
            : const Center(child: Text('Keranjang kosong')),
      ),
    );
  }
}
