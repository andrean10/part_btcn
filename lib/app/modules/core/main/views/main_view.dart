import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_btcn/shared/shared_enum.dart';

import '../controllers/main_controller.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () {
          final role = controller.role.value;
          return IndexedStack(
            index: controller.selectedIndex.value,
            children: switch (role) {
              Role.admin => controller.listScreenAdmin,
              Role.direktur => controller.listScreenDirektur,
              Role.finance => controller.listScreenFinance,
              Role.user => controller.listScreenUser,
              null => throw UnimplementedError(),
            },
          );
        },
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          destinations: switch (controller.role.value) {
            Role.admin => controller.listMenuAdmin,
            Role.direktur => controller.listMenuDirektur,
            Role.finance => controller.listMenuFinance,
            Role.user => controller.listMenuUser,
            null => throw UnimplementedError(),
          }
              .map(
                (e) => NavigationDestination(
                  icon: Icon(e.icon),
                  selectedIcon: Icon(e.selectedIcon),
                  label: e.label,
                  tooltip: e.label,
                ),
              )
              .toList(),
          onDestinationSelected: controller.onDestinationSelected,
        ),
      ),
    );
  }
}
