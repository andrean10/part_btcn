import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/chat/screen/detail_chat_screen.dart';

import '../controllers/detail_chat_controller.dart';

class DetailChatView extends GetView<DetailChatController> {
  const DetailChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return const DetailChatScreen();
  }
}
