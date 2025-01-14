import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:part_btcn/app/data/db/menu_item.dart';
import 'package:part_btcn/app/modules/core/home/views/home_view.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';
import 'package:part_btcn/app/modules/core/history_order/controllers/history_order_controller.dart';
import 'package:part_btcn/app/modules/core/history_order/views/history_order_view.dart';

import '../../../../../shared/shared_enum.dart';
import '../../information/controllers/information_controller.dart';
import '../../information/views/information_view.dart';
import '../../chat/controllers/chat_controller.dart';
import '../../chat/views/chat_view.dart';
import '../../profile/views/profile_view.dart';

class MainController extends GetxController {
  late final InitController _initC;

  final listMenuAdmin = [
    MenuItem(
      icon: Icons.fact_check_outlined,
      selectedIcon: Icons.fact_check_rounded,
      label: 'Home',
    ),
    MenuItem(
      icon: Icons.message_outlined,
      selectedIcon: Icons.message_rounded,
      label: 'Pesan',
    ),
    MenuItem(
      icon: Icons.account_circle_outlined,
      selectedIcon: Icons.account_circle_rounded,
      label: 'Profile',
    ),
  ];

  final listMenuFinance = [
    MenuItem(
      icon: Icons.point_of_sale_outlined,
      selectedIcon: Icons.point_of_sale_rounded,
      label: 'Home',
    ),
    MenuItem(
      icon: Icons.account_circle_outlined,
      selectedIcon: Icons.account_circle_rounded,
      label: 'Profile',
    ),
  ];

  final listMenuUser = [
    MenuItem(
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
      label: 'Home',
    ),
    // MenuItem(
    //   icon: Icons.shopping_cart_outlined,
    //   selectedIcon: Icons.shopping_cart_rounded,
    //   label: 'Keranjang',
    // ),
    MenuItem(
      icon: Icons.history_outlined,
      selectedIcon: Icons.history_rounded,
      label: 'Riwayat',
    ),
    MenuItem(
      icon: Icons.info_outline_rounded,
      selectedIcon: Icons.info_rounded,
      label: 'Informasi',
    ),
    MenuItem(
      icon: Icons.account_circle_outlined,
      selectedIcon: Icons.account_circle_rounded,
      label: 'Profile',
    ),
  ];

  final listMenuDirektur = [
    MenuItem(
      icon: Icons.analytics_outlined,
      selectedIcon: Icons.analytics_rounded,
      label: 'Laporan',
    ),
    MenuItem(
      icon: Icons.account_circle_outlined,
      selectedIcon: Icons.account_circle_rounded,
      label: 'Profile',
    ),
  ];

  final selectedIndex = 0.obs;
  final role = Rxn<Role>();

  final listScreenAdmin = [
    const HomeView(),
    const ChatView(),
    const ProfileView(),
  ];

  final listScreenDirektur = [
    const HomeView(),
    const ProfileView(),
  ];

  final listScreenFinance = [
    const HomeView(),
    const ProfileView(),
  ];

  final listScreenUser = [
    const HomeView(),
    const HistoryOrderView(),
    const InformationView(),
    const ProfileView(),
  ];

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (!Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    role.value = Get.arguments as Role;

    switch (role.value) {
      case Role.admin:
        Get.put(ChatController());
        break;
      case Role.user:
        Get.put(HistoryOrderController());
        Get.put(InformationController());
        break;
      default:
    }
  }

  void onDestinationSelected(int value) => selectedIndex.value = value;
}
