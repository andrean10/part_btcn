import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/home/screen/home_admin_screen.dart';
import 'package:part_btcn/app/modules/core/home/screen/home_finance_screen.dart';

import '../../../../../shared/shared_enum.dart';
import '../controllers/home_controller.dart';
import '../screen/home_director_screen.dart';
import '../screen/home_user_screen.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: switch (controller.mainC.role.value) {
        Role.admin => const HomeAdminScreen(),
        Role.direktur => const HomeDirectorScreen(),
        Role.finance => const HomeFinanceScreen(),
        Role.user => const HomeUserScreen(),
        _ => const SizedBox.shrink(),
      },
    );
  }
}
