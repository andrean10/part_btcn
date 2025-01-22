import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:part_btcn/app/data/model/parts/part_model.dart';
import 'package:part_btcn/app/data/model/parts/review/review_model.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';
import 'package:part_btcn/app/modules/widgets/modal/modals.dart';
import 'package:part_btcn/shared/shared_theme.dart';

import '../../../../../utils/constants_assets.dart';
import '../../../widgets/buttons/buttons.dart';
import '../controllers/detail_part_controller.dart';

class DetailPartView extends GetView<DetailPartController> {
  const DetailPartView({super.key});
  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;
    final size = context.mediaQuerySize;

    return Scaffold(
      appBar: _builderAppBar(textTheme),
      body: _builderBody(theme, textTheme, size),
      persistentFooterButtons: _builderFooter(textTheme),
    );
  }

  AppBar _builderAppBar(TextTheme textTheme) {
    return AppBar(
      title: const Text('Detail Part'),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: controller.moveToCart,
          icon: Stack(
            children: [
              const Icon(Icons.shopping_cart_rounded),
              ObxValue(
                (total) => Visibility(
                  visible: total.value > 0,
                  child: Positioned(
                    top: 0,
                    right: 0,
                    child: Badge.count(
                      count: total.value,
                      textStyle: textTheme.labelSmall?.copyWith(fontSize: 8),
                    ),
                  ),
                ),
                controller.totalItemsCart,
              ),
            ],
          ),
          tooltip: 'Keranjang',
        ),
        IconButton(
          onPressed: controller.moveToChat,
          icon: const Icon(Icons.chat_rounded),
          tooltip: 'Chat',
        ),
        const SizedBox(width: 4),
      ],
    );
  }

  Widget _builderBody(ThemeData theme, TextTheme textTheme, Size size) {
    final part = controller.dataPart;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlutterCarousel.builder(
            itemCount: part?.images?.length ?? 0,
            itemBuilder: (context, index, realIndex) {
              final image = part?.images?[index];

              return CachedNetworkImage(
                imageUrl: image ?? '',
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
                  ConstantsAssets.imgNoPicture,
                  fit: BoxFit.cover,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  ConstantsAssets.imgNoPicture,
                  fit: BoxFit.cover,
                ),
                imageBuilder: (context, imageProvider) => Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            },
            options: FlutterCarouselOptions(
              viewportFraction: 1,
              height: size.height * 0.5,
              // aspectRatio: 4 / 5,
              slideIndicator: CircularSlideIndicator(
                slideIndicatorOptions: SlideIndicatorOptions(
                  currentIndicatorColor: theme.colorScheme.primaryContainer,
                  // enableHalo: true,
                  enableAnimation: true,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    TextHelper.formatRupiah(
                      amount: part?.price,
                      isCompact: false,
                    ),
                  ),
                ),
                Flexible(
                  child: Text(part?.id ?? '-'),
                ),
              ],
            ),
            subtitle: Text(part?.description ?? ''),
            subtitleTextStyle: textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          _builderReview(theme, textTheme, size),
        ],
      ),
    );
  }

  Widget _builderReview(ThemeData theme, TextTheme textTheme, Size size) {
    return FirestoreQueryBuilder(
      query: controller.colReviews().orderBy(
            FieldPath.fromString('createdAt'),
            descending: true,
          ),
      builder: (context, snapshot, child) {
        if (snapshot.isFetching) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Gagal memuat data review'));
        }

        if (snapshot.hasData && snapshot.docs.isNotEmpty) {
          final reviews = snapshot.docs.map((e) => e.data()).toList();
          return Container(
            width: double.infinity,
            color: theme.colorScheme.surfaceContainerLowest,
            padding: const EdgeInsets.symmetric(
              horizontal: 21,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              AutoSizeText(
                  'Review',
                  style: textTheme.titleLarge,
                ),
                const SizedBox(height: 2),
                Divider(endIndent: size.width / 1.7),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final review = reviews[index];
                    return _builderTileReview(textTheme, review);
                  },
                  separatorBuilder: (context, index) =>
                      const Divider(thickness: 0.3),
                  itemCount: (reviews.length < 3) ? reviews.length : 3,
                ),
                Visibility(
                  visible: reviews.length > 3,
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: Buttons.text(
                      width: double.infinity,
                      onPressed: () => _showModal(textTheme, reviews),
                      child: const Text('Lihat Semua'),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  List<Widget> _builderFooter(TextTheme textTheme) {
    final part = controller.dataPart;
    return [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Jumlah Pembelian',
                  style: textTheme.labelLarge,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: controller.decQuantity,
                      icon: const Icon(Icons.remove_circle_rounded),
                    ),
                    ObxValue(
                        (quantity) => Text(
                              '${quantity.value}',
                              style: textTheme.labelLarge,
                            ),
                        controller.quantity),
                    IconButton(
                      onPressed: controller.incQuantity,
                      icon: const Icon(Icons.add_circle_rounded),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ObxValue(
                    (totalPrice) {
                      final total = totalPrice.value != 0
                          ? totalPrice.value
                          : part?.price;

                      return Text(
                        TextHelper.formatRupiah(
                          amount: total,
                          isCompact: false,
                        ),
                        style: textTheme.titleLarge,
                      );
                    },
                    controller.totalPrice,
                  ),
                ),
                const SizedBox(width: 4),
                Row(
                  children: [
                    IconButton.filledTonal(
                      onPressed: controller.addToCart,
                      icon: const Icon(Icons.shopping_cart_rounded),
                    ),
                    const SizedBox(width: 2),
                    Buttons.filled(
                      onPressed: controller.checkout,
                      child: const Text('Checkout'),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ];
  }

  Widget _builderTileReview(TextTheme textTheme, ReviewModel review) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const CircleAvatar(
        backgroundImage: AssetImage(ConstantsAssets.imgNoPhoto),
      ),
      title: Text(review.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            review.text,
            maxLines: 4,
            overflow: TextOverflow.ellipsis,
            style: textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              FormatDateTime.dateToString(
                newPattern: 'dd MMM yyyy, HH:mm',
                value: review.createdAt.toString(),
              ),
              style: textTheme.labelSmall,
            ),
          ),
        ],
      ),
      titleTextStyle: textTheme.titleMedium?.copyWith(
        fontWeight: SharedTheme.bold,
      ),
      isThreeLine: true,
    );
  }

  void _showModal(TextTheme textTheme, List<ReviewModel> reviews) {
    Modals.bottomSheetScroll(
      context: Get.context!,
      content: ListView.separated(
        itemBuilder: (context, index) {
          final review = reviews[index];
          return _builderTileReview(textTheme, review);
        },
        separatorBuilder: (context, index) => const Divider(thickness: 0.3),
        itemCount: reviews.length,
      ),
    );
  }
}
