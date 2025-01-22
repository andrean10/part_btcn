import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../../../../../utils/constants_assets.dart';
import '../../../../data/model/chat/chat_model.dart';
import '../controllers/detail_chat_controller.dart';

class DetailChatView extends StatefulWidget {
  const DetailChatView({super.key});

  @override
  State<DetailChatView> createState() => _DetailChatViewState();
}

class _DetailChatViewState extends State<DetailChatView> {
  final controller = Get.find<DetailChatController>();
  final List<types.Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _initStream();
  }

  Future<void> _initStream() async {
    final colChats = controller.colChats();

    // jika role user

    ChatModel? dataChat;

    print('role = ${controller.role}');

    if (controller.role == 'user') {
      // user
      // ambil data
      final queryChat = await colChats
          .where(
            FieldPath.fromString('participants'),
            arrayContains: controller.userId,
          )
          .limit(1)
          .get();
      dataChat = queryChat.docs.firstOrNull?.data();
      controller.dataChat.value = dataChat;
    } else {
      // admin
      dataChat = controller.dataChat.value;
    }

    if (dataChat != null) {
      final chatId = dataChat.id;

      final snapshotMessages = controller
          .colMessages(chatId)
          .orderBy('createdAt', descending: true)
          .snapshots();

      snapshotMessages.listen(
        (event) {
          final mapMessage = event.docs.map(
            (e) {
              final message = e.data();

              return types.TextMessage(
                author: types.User(id: '${message.userId}'),
                id: e.id,
                text: message.text,
                createdAt: message.createdAt?.millisecondsSinceEpoch,
                type: types.MessageType.text,
              );
            },
          ).toList();

          if (mapMessage.isNotEmpty) {
            setState(() {
              _messages.clear();
              _messages.addAll(mapMessage);
            });
          }
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: _builderAppBar(
        textTheme: textTheme,
        controller: controller,
      ),
      body: Chat(
        theme: DefaultChatTheme(
          backgroundColor: theme.colorScheme.surface,
          inputBackgroundColor: theme.colorScheme.secondaryContainer,
          inputTextColor: theme.colorScheme.onSurface,
        ),
        user: types.User(
          id: '${controller.userId}',
          role: types.Role.user,
        ),
        messages: _messages,
        onSendPressed: controller.handleSendPressed,
      ),
    );
  }
}

AppBar _builderAppBar({
  required TextTheme textTheme,
  required DetailChatController controller,
}) {
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
            Builder(builder: (context) {
              var name = 'Admin';

              if (controller.role == 'admin') {
                name = controller.dataChat.value?.userName ?? '';
              }

              return Text(
                name,
                style: textTheme.titleSmall,
              );
            }),
          ],
        ),
      ],
    ),
    centerTitle: false,
  );
}
