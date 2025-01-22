import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/helpers/format_date_time.dart';
import 'package:part_btcn/app/modules/core/chat/controllers/chat_controller.dart';
import 'package:part_btcn/utils/constants_assets.dart';

class ChatAdminScreen extends GetView<ChatController> {
  const ChatAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: _builderAppBar(textTheme),
      body: _builderBody(),
    );
  }

  AppBar _builderAppBar(TextTheme textTheme) {
    return AppBar(
      title: const Text('Chat'),
      centerTitle: false,
    );
  }

  Widget _builderBody() {
    return FirestoreListView(
      query: controller
          .colChats()
          .orderBy('lastMessage.createdAt', descending: true),
      itemBuilder: (context, doc) {
        final dataChat = doc.data();
        return Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage(ConstantsAssets.imgNoPhoto),
              ),
              title: Text(dataChat.userName ?? '-'),
              subtitle: Text(dataChat.lastMessage?.text ?? ''),
              trailing: Text(
                FormatDateTime.dateToString(
                  newPattern: 'HH:mm',
                  value: dataChat.lastMessage?.createdAt?.toString(),
                ),
              ),
              // isThreeLine: true,
              onTap: () => controller.moveToDetailChat(dataChat),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
