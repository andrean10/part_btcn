import 'dart:convert';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';

import '../../../../../shared/shared_enum.dart';
import '../../../../routes/app_pages.dart';

class ChatController extends GetxController {
  late final InitController _initC;

  final role = Rxn<Role>();

  final messages = RxList<types.Message>.empty();

  final rooms = RxList<types.Room>.empty();
  final users = RxList<types.User>.empty();

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

    users.addAll([
      _initC.user2,
      _initC.user3,
    ]);
  }

  // @override
  // void onReady() {
  //   super.onReady();
  // }

  types.User getAdmin() => _initC.user;

  List<types.User> getListUsers() => users;

  void _addMessage(types.Message message) {
    messages.add(message);
  }

  void handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      author: messages.length.isOdd ? _initC.user : _initC.user2,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: randomString(),
      text: message.text,
      showStatus: true,
      status: types.Status.seen,
    );

    _addMessage(textMessage);
  }

  void handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _initC.user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: randomString(),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
        status: types.Status.seen,
      );

      _addMessage(message);
    }
  }

  String randomString() {
    final random = Random.secure();
    final values = List<int>.generate(16, (i) => random.nextInt(255));
    return base64UrlEncode(values);
  }

  String getPicture() => _initC.user.imageUrl ?? '';

  // types.Role? getRole() => _initC.user.role;

  void moveToDetailChat() => Get.toNamed(Routes.DETAIL_CHAT);
}
