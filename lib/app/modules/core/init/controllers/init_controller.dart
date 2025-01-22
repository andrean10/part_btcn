import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

import '../../../../routes/app_pages.dart';

class InitController extends GetxController {
  late final FirebaseAuth _auth;
  late final FirebaseFirestore _firestore;
  late final GetStorage _storage;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  GetStorage get localStorage => _storage;

  late final Logger logger;

  @override
  void onInit() {
    super.onInit();

    _auth = FirebaseAuth.instance;
    _firestore = FirebaseFirestore.instance;
    _storage = GetStorage();

    logger = Logger(
      printer: PrettyPrinter(
        dateTimeFormat: DateTimeFormat.onlyTime,
      ),
    );
  }

  Future<void> logout() async {
    try {
      await _storage.erase();
      await _auth.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } on FirebaseAuthException catch (e) {
      logger.e('Error: $e');
    }
  }
}
