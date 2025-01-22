import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/chat/message/message_model.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';

import 'package:part_btcn/utils/constants_keys.dart';

import '../../../../data/model/chat/chat_model.dart';

class DetailChatController extends GetxController {
  late final InitController _initC;
  StreamSubscription<QuerySnapshot<MessageModel>>? subsMessage;
  // final chatKey = GlobalKey<ChatState>();

  String? userId;
  String? name;
  String? role;

  final chatId = RxnString();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  Future<void> _init() async {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    userId = _initC.localStorage.read(ConstantsKeys.id);
    name = _initC.localStorage.read(ConstantsKeys.name);
    role = _initC.localStorage.read(ConstantsKeys.role);
  }

  Future<void> checkHadCollection() async {
    try {
      final queryChats = await colChats()
          .where(
            FieldPath.fromString('participants'),
            arrayContains: userId,
          )
          .get();

      if (queryChats.size != 0) {
        final docChats = queryChats.docs.firstOrNull;

        if (docChats != null && docChats.exists) {
          chatId.value = docChats.id;
        }
      }
    } on FirebaseException catch (e) {
      _initC.logger.e('Error: code = ${e.code}\n${e.message}');
    }
  }

  CollectionReference<ChatModel> colChats() {
    final col = _initC.firestore.collection('chats').withConverter(
          fromFirestore: (snapshot, _) => ChatModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  CollectionReference<MessageModel> colMessages(String chatId) {
    final col = colChats().doc(chatId).collection('messages').withConverter(
          fromFirestore: (snapshot, _) =>
              MessageModel.fromJson(snapshot.data()!),
          toFirestore: (model, _) => model.toJson(),
        );
    return col;
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }
}
