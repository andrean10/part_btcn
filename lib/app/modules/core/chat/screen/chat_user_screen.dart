import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/chat/controllers/chat_controller.dart';
import 'package:part_btcn/app/modules/core/chat/screen/detail_chat_screen.dart';

class ChatUserScreen extends GetView<ChatController> {
  const ChatUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailChatScreen();
  }
}
