import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

import 'package:get/get.dart';
import 'package:part_btcn/app/data/model/chat/message/message_model.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';

import 'package:part_btcn/utils/constants_keys.dart';

import '../../../../data/model/chat/chat_model.dart';

class DetailChatController extends GetxController {
  late final InitController _initC;
  StreamSubscription<QuerySnapshot<MessageModel>>? subsMessage;

  String? userId;
  String? name;
  String? role;

  final dataChat = Rxn<ChatModel>();

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

    if (role == 'admin') {
      dataChat.value = Get.arguments as ChatModel;
    }
  }

  // Future<void> checkHadCollection() async {
  //   try {
  //     final queryChats = await colChats()
  //         .where(
  //           FieldPath.fromString('participants'),
  //           arrayContains: userId,
  //         )
  //         .get();

  //     if (queryChats.size != 0) {
  //       final docChats = queryChats.docs.first;

  //       if (docChats.exists) {
  //         dataChat.value = docChats.data();
  //       }
  //     }
  //   } on FirebaseException catch (e) {
  //     _initC.logger.e('Error: code = ${e.code}\n${e.message}');
  //   }
  // }

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

  void handleSendPressed(types.PartialText message) {
    final colMsg = colMessages('${dataChat.value?.id}');
    final docMsg = colMsg.doc();

    final textMessage = types.TextMessage(
      id: docMsg.id,
      author: types.User(id: '$userId'),
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: message.text,
    );

    _addMessage(
      message: textMessage,
      msgText: message.text,
    );
  }

  Future<void> _addMessage({
    required types.Message message,
    required String msgText,
  }) async {
    final now = DateTime.now();
    final chatId = dataChat.value?.id;
    final msg = MessageModel(
      id: message.id,
      userId: userId,
      text: msgText,
      createdAt: now,
    );

    await colMessages('$chatId').doc(message.id).set(msg);
    
    // update last message
    if (dataChat.value != null) {
      final newLastMessage = <String, dynamic>{
        'lastMessage': {
          'id': message.id,
          'createdAt': now,
          'text': msgText,
        },
      };

      if (role == 'user') {
        newLastMessage.addAll({'userName': name});
      }

      print('newLastMessage = $newLastMessage');

      await colChats().doc(chatId).update(newLastMessage);
    }
  }
}
