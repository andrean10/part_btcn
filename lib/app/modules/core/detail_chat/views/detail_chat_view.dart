import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';

import '../../../../../utils/constants_assets.dart';
import '../../../../data/model/chat/message/message_model.dart';
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
    final dataChat = await colChats
        .where(
          FieldPath.fromString('participants'),
          arrayContains: controller.userId,
        )
        .get();

    if (dataChat.size != 0) {
      final docChats = dataChat.docs.first;
      final chatId = docChats.id;
      controller.chatId.value = chatId;

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

  Future<void> _addMessage(types.Message message, String msgText) async {
    final msg = MessageModel(
      id: message.id,
      userId: controller.userId,
      text: msgText,
      createdAt: DateTime.now(),
    );

    await controller
        .colMessages('${controller.chatId}')
        .doc(message.id)
        .set(msg);
  }

  void _handleSendPressed(types.PartialText message) {
    final colMsg = controller.colMessages('${controller.chatId}');
    final docMsg = colMsg.doc();

    final textMessage = types.TextMessage(
      author: types.User(id: '${controller.userId}'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: docMsg.id,
      text: message.text,
    );

    _addMessage(textMessage, message.text);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: _builderAppBar(textTheme),
      body: Chat(
        theme: DefaultChatTheme(
          backgroundColor: theme.colorScheme.surface,
          inputBackgroundColor: theme.colorScheme.secondaryContainer,
          inputTextColor: theme.colorScheme.onSurface,
        ),
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: types.User(id: '${controller.userId}'),
      ),
    );
  }
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
