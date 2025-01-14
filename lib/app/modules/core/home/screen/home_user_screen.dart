import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/data/parts/part_model.dart';
import 'package:part_btcn/app/helpers/text_helper.dart';
import 'package:part_btcn/utils/constants_assets.dart';

import '../controllers/home_controller.dart';

class HomeUserScreen extends GetView<HomeController> {
  const HomeUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;
    final size = context.mediaQuerySize;

    return Scaffold(
      appBar: _buildAppBar(size, textTheme),
      body: RefreshIndicator.adaptive(
        onRefresh: () => controller.fetchColModels(),
        child: _buildGridView(
          size,
          textTheme,
          theme,
        ),
      ),
    );
  }

  AppBar _buildAppBar(Size size, TextTheme textTheme) {
    return AppBar(
      leading: Container(
        margin: const EdgeInsets.only(left: 12),
        child: SvgPicture.asset(ConstantsAssets.icLogoApp),
      ),
      leadingWidth: 80,
      actions: _buildAppBarActions(textTheme),
      bottom: _buildAppBarBottom(size),
    );
  }

  List<Widget> _buildAppBarActions(TextTheme textTheme) {
    return [
      IconButton(
        onPressed: controller.moveToCart,
        icon: Stack(
          children: [
            const Icon(Icons.shopping_cart_rounded),
            Positioned(
              top: 0,
              right: 0,
              child: Badge.count(
                count: 3,
                textStyle: textTheme.labelSmall?.copyWith(fontSize: 8),
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
    ];
  }

  PreferredSize _buildAppBarBottom(Size size) {
    return PreferredSize(
      preferredSize: Size.fromHeight(size.height * 0.08),
      child: SizedBox(
        width: double.infinity,
        child: controller.obx(
          (data) {
            final length = data!.length;
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 12),
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  length,
                  (index) => Container(
                    margin: EdgeInsets.only(
                      left: (index == 0) ? 16 : 8,
                      right: (index == (length - 1)) ? 16 : 8,
                    ),
                    child: Obx(
                      () => ChoiceChip(
                        label: Text(data[index].id),
                        selected: index == controller.categoryIndex.value,
                        showCheckmark: false,
                        onSelected: (_) =>
                            controller.setCategory(data[index].id),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          onLoading: const LinearProgressIndicator(),
          onEmpty: const Center(child: Text('Data kosong')),
          onError: (error) => const Center(child: Text('Gagal memuat data')),
        ),
      ),
    );
  }

  Widget _buildGridView(Size size, TextTheme textTheme, ThemeData theme) {
    return ObxValue(
      (data) {
        final id = data.value;

        if (id != null) {
          return FirestoreQueryBuilder(
            query: controller.colModels(modelId: id),
            builder: (context, snapshot, child) {
              if (snapshot.isFetching) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return const Center(child: Text('Gagal memuat data'));
              }

              if (!snapshot.hasData && snapshot.docs.isEmpty) {
                return const Center(child: Text('Model belum ada'));
              }

              if (snapshot.hasData) {
                final dataModel = snapshot.docs
                    .firstWhere((element) => element.id == id)
                    .data();
                final parts = dataModel.parts;

                if (parts != null) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 21,
                      childAspectRatio: size.aspectRatio * 1.4,
                    ),
                    itemBuilder: (context, index) {
                      final part = parts[index];
                      return GestureDetector(
                        onTap: () => controller.showDetailPart(),
                        child: _buildGridTile(textTheme, theme, part),
                      );
                    },
                    itemCount: parts.length,
                  );
                } else {
                  return const Center(child: Text('Belum ada part'));
                }
              }

              return const SizedBox.shrink();
            },
          );
        }

        return const Center(child: Text('Data kosong'));
      },
      controller.modelId,
    );
  }

  Widget _buildGridTile(TextTheme textTheme, ThemeData theme, PartModel part) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: GridTile(
        footer: _buildGridTileBar(textTheme, theme, part),
        child: CachedNetworkImage(
          imageUrl: part.images?.firstOrNull ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => Image.asset(
            ConstantsAssets.imgNoPicture,
            fit: BoxFit.cover,
          ),
          errorWidget: (context, url, error) => Image.asset(
            ConstantsAssets.imgNoPicture,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildGridTileBar(
      TextTheme textTheme, ThemeData theme, PartModel part) {
    return GridTileBar(
      backgroundColor: theme.colorScheme.surfaceContainerHigh,
      title: Text(
        part.id,
        style: textTheme.labelMedium,
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            part.description,
            style: textTheme.titleSmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            TextHelper.formatRupiah(amount: part.price, isCompact: false),
            style: textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}