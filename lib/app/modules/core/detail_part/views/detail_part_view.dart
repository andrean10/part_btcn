import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';
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
      appBar: AppBar(
        title: const Text('Detail Part'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: controller.moveToCart,
            icon: Stack(
              children: [
                const Icon(Icons.shopping_cart_rounded),
                Positioned(
                  top: 0,
                  right: 0,
                  child: Obx(
                    () => Badge.count(
                      count: controller.carts.length,
                      textStyle: textTheme.labelSmall?.copyWith(fontSize: 8),
                    ),
                  ),
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
      ),
      body: _builderBody(theme, textTheme, size),
      persistentFooterButtons: [
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
                        onPressed: () {},
                        icon: const Icon(Icons.remove_circle_rounded),
                      ),
                      Text('1', style: textTheme.labelLarge),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.add_circle_rounded),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      TextHelper.formatRupiah(
                        amount: 236600,
                        isCompact: false,
                      ),
                      style: textTheme.titleLarge,
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
      ],
    );
  }

  Widget _builderBody(ThemeData theme, TextTheme textTheme, Size size) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FlutterCarousel.builder(
            itemCount: controller.images.length,
            itemBuilder: (context, index, realIndex) {
              final image = controller.images[index];
              return CachedNetworkImage(
                imageUrl: image,
                fit: BoxFit.cover,
                placeholder: (context, url) => Image.asset(
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
                      amount: 236600,
                      isCompact: false,
                    ),
                  ),
                ),
                const Flexible(
                  child: Text('40C0441P01'),
                ),
              ],
            ),
            subtitle: const Text('ENGINE OIL FILTER ELEMENT 机油滤芯'),
            subtitleTextStyle: textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Container(
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
                const SizedBox(height: 12),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const CircleAvatar(
                        backgroundImage: AssetImage(ConstantsAssets.imgNoPhoto),
                      ),
                      title: const Text('PT. Angkasa Pura'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Produknya bagus dan berkualitas, tak nyesal order lagi disini, pelayanan memuaskan.. Gacorr!!!',
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 4),
                          Align(
                            alignment: Alignment.topRight,
                            child: Text(
                              FormatDateTime.dateToString(
                                newPattern: 'dd MMMM yyyy',
                                value: DateTime.now().toString(),
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
                  },
                  separatorBuilder: (context, index) => const Divider(
                    thickness: 0.3,
                  ),
                  itemCount: 3,
                ),
                // const SizedBox(height: 16),
                // Buttons.text(
                //   width: double.infinity,
                //   onPressed: ,
                //   child: const Text('Lihat Semua'),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
