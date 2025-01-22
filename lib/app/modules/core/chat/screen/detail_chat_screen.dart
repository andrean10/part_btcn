import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/chat/controllers/chat_controller.dart';

import '../../../../../utils/constants_assets.dart';

class DetailChatScreen extends GetView<ChatController> {
  const DetailChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: _builderAppBar(textTheme),
      body: _builderBody(context, theme),
    );
  }

  AppBar _builderAppBar(TextTheme textTheme) {
    return AppBar(
      title: Row(
        children: [
          const CircleAvatar(
            foregroundImage: AssetImage(ConstantsAssets.imgNoPhoto),
            radius: 20,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Admin',
                style: textTheme.titleSmall,
              ),
            ],
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  Widget _builderBody(BuildContext context, ThemeData theme) {
    return const SizedBox.shrink();

    // return Obx(
    //   () => Chat(
    //     theme: DefaultChatTheme(
    //       backgroundColor: theme.colorScheme.surface,
    //       inputBackgroundColor: theme.colorScheme.secondaryContainer,
    //       inputTextColor: theme.colorScheme.onSurface,
    //     ),
    //     messages: controller.messages.value.reversed.toList(),
    //     onSendPressed: controller.handleSendPressed,
    //     onAttachmentPressed: controller.handleFileSelection,
    //     user: controller.getAdmin(),
    //     isAttachmentUploading: false,
    //     emptyState: Center(
    //       child: Text(
    //         'Belum ada pesan',
    //         style: context.textTheme.bodyMedium,
    //       ),
    //     ),
    //     isLastPage: true,
    //   ),
    // );
  }
}
