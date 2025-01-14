import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/chat/screen/chat_admin_screen.dart';

import '../../../../../shared/shared_enum.dart';
import '../controllers/chat_controller.dart';
import '../screen/chat_user_screen.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final role = controller.role;
    if (role.value == Role.admin) {
      return const ChatAdminScreen();
    } else {
      return const ChatUserScreen();
    }
  }
}
