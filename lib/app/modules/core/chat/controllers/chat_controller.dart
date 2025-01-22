import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/user/users_model.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../data/model/chat/chat_model.dart';
import '../../../../routes/app_pages.dart';

class ChatController extends GetxController {
  late final InitController _initC;

  final role = Rxn<Role>();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    role.value = Get.arguments as Role;
  }

  CollectionReference<ChatModel> colChats() {
    final col = _initC.firestore.collection('chats').withConverter(
          fromFirestore: (snapshot, _) => ChatModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  Future<void> fetchChats() async {
    final queryChats = await colChats()
        .orderBy('lastMessage.createdAt', descending: true)
        .get();
    final docChats = queryChats.docs;
  }

  CollectionReference<UsersModel> colUser() {
    final col = _initC.firestore.collection('users').withConverter(
          fromFirestore: (snapshot, _) => UsersModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  void moveToDetailChat() => Get.toNamed(Routes.DETAIL_CHAT);
}
