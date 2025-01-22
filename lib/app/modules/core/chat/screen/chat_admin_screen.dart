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
      centerTitle: false, // true,  // false,
    );
  }

  Widget _builderBody() {
    return FirestoreListView(
      query: controller
          .colChats()
          .orderBy('lastMessage.createdAt', descending: true),
      itemBuilder: (context, doc) {
        final chat = doc.data();

        return Column(
          children: [
            ListTile(
              leading: const CircleAvatar(
                backgroundImage: AssetImage(ConstantsAssets.imgNoPhoto),
              ),
              title: Text('Testing'),
              subtitle: Text(chat.lastMessage?.text ?? ''),
              trailing: Text(
                FormatDateTime.dateToString(
                  newPattern: 'HH:mm',
                  value: chat.lastMessage?.createdAt?.toIso8601String(),
                ),
              ),
              // isThreeLine: true,
              onTap: controller.moveToDetailChat,
            ),
            const Divider(),
          ],
        );
      },
    );

    // return ListView.builder(
    //   itemBuilder: (context, index) {
    //     final user = controller.users[index];
    //     return Column(
    //       children: [
    //         ListTile(
    //           leading: const CircleAvatar(
    //             backgroundImage: AssetImage(ConstantsAssets.imgNoPhoto),
    //           ),
    //           title: Text('${user.firstName} ${user.lastName}'),
    //           subtitle: const Text('Boleh pak kalau begitu'),
    //           trailing: Text(
    //             FormatDateTime.dateToString(
    //               newPattern: 'HH:mm',
    //               value: DateTime.now().toString(),
    //             ),
    //           ),
    //           // isThreeLine: true,
    //           onTap: controller.moveToDetailChat,
    //         ),
    //         const Divider(),
    //       ],
    //     );
    //   },
    //   // separatorBuilder: (context, index) => const SizedBox(height: 12),
    //   itemCount: controller.users.length,
    // );
  }
}
