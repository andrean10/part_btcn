import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:part_btcn/shared/shared_method.dart';

import '../../../../../utils/constants_keys.dart';
import '../../../../data/model/user/users_model.dart';
import '../../../../routes/app_pages.dart';
import '../../../core/init/controllers/init_controller.dart';

class LoginController extends GetxController {
  late final InitController _initC;

  final formKey = GlobalKey<FormState>();
  final emailC = TextEditingController();
  final passwordC = TextEditingController();

  final emailF = FocusNode();
  final passwordF = FocusNode();

  final email = ''.obs;
  final password = ''.obs;

  final isLoading = false.obs;
  final isVisiblePassword = false.obs;
  final isHidePassword = true.obs;

  // DUMMY ADMIN
  final emailDummyAdmin = 'sandradia@gmail.com';
  final passwordDummyAdmin = '12345678';

  // DUMMY USER
  final emailDummyUser = 'user@gmail.com';
  final passwordDummyUser = '12345678';

  // DUMMY FINANCE
  final emailDummyFinance = 'finance@gmail.com';
  final passwordDummyFinance = '12345678';

  // DUMMY DIREKTUR
  final emailDummyDirektur = 'director@gmail.com';
  final passwordDummyDirektur = '12345678';

  final errMsg = RxnString();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }
    _initListener();
    _workerListener();
  }

  void _initListener() {
    _setListener(obs: email, ctr: emailC);
    _setListener(obs: password, ctr: passwordC);
  }

  void _workerListener() {
    everAll([email, password], (_) => _clearError());
  }

  void _setListener({
    required Rx obs,
    required TextEditingController ctr,
  }) =>
      ctr.addListener(() => obs.value = ctr.text);

  void nextFocus(FocusNode node) => node.requestFocus();

  void setHidePassword() => isHidePassword.toggle();

  Future<void> confirm() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    FocusScope.of(Get.context!).unfocus();
    _checkAuth();
  }

  Future<void> _checkAuth() async {
    isLoading.value = true;

    final email = emailC.text.toString().trim();
    final password = passwordC.text.toString().trim();

    try {
      final userCredential = await _initC.auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        // cek role
        final docUser = await _initC.firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .withConverter(
              fromFirestore: (snapshot, _) =>
                  UsersModel.fromJson(snapshot.data()!),
              toFirestore: (model, _) => model.toJson(),
            )
            .get();

        if (docUser.exists) {
          final user = docUser.data()!;
          _moveToMain(user);
        } else {
          _initC.logger.e('User tidak ditemukan');
          errMsg.value = 'User tidak ditemukan';
        }
      }
    } on FirebaseAuthException catch (e) {
      _initC.logger.e('Error: $e');

      if (e.code == 'user-not-found') {
        errMsg.value = 'User dengan email tersebut tidak ditemukan';
      } else if (e.code == 'wrong-password') {
        errMsg.value = 'Password yang anda masukkan salah';
      } else {
        errMsg.value = 'Terjadi kesalahan, silahkan coba lagi';
      }
    } finally {
      isLoading.value = false;
    }

    // if (email == emailDummyAdmin && password == passwordDummyAdmin) {
    //   _moveToMain(Role.admin);
    // } else if (email == emailDummyDirektur &&
    //     password == passwordDummyDirektur) {
    //   _moveToMain(Role.direktur);
    // } else if (email == emailDummyFinance && password == passwordDummyFinance) {
    //   _moveToMain(Role.finance);
    // } else if (email == emailDummyUser && password == passwordDummyUser) {
    //   _moveToMain(Role.user);
    // } else {
    //   Snackbar.failed(
    //     context: Get.context!,
    //     content: 'Email atau password yang anda masukkan salah',
    //   );
    // }
  }

  void _moveToMain(UsersModel user) {
    final role = checkRole(user.role);
    _writeDataProfile(user);
    Get.offAllNamed(Routes.MAIN, arguments: role);
  }

  void _writeDataProfile(UsersModel user) {
    _initC.localStorage
      ..write(ConstantsKeys.id, user.id)
      ..write(ConstantsKeys.name, user.name)
      ..write(ConstantsKeys.email, user.email)
      ..write(ConstantsKeys.role, user.role);
  }

  void _clearError() => errMsg.value = null;
}
