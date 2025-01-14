import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../utils/constants_assets.dart';
import '../../../widgets/buttons/buttons.dart';
import '../../../widgets/card/cards.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          Buttons.text(
            onPressed: controller.logout,
            child: const Text('Logout'),
          ),
          const SizedBox(width: 6),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage(ConstantsAssets.imgNoPhoto),
              radius: 62,
            ),
            const SizedBox(height: 32),
            Cards.filled(
              context: context,
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Nama'),
                    subtitle: Text(controller.name),
                    titleTextStyle: textTheme.titleMedium,
                    subtitleTextStyle: textTheme.bodyMedium,
                  ),
                  ListTile(
                    title: const Text('Role'),
                    subtitle: Text(controller.role),
                    titleTextStyle: textTheme.titleMedium,
                    subtitleTextStyle: textTheme.bodyMedium,
                  ),
                  ListTile(
                    title: const Text('Email'),
                    subtitle: Text(controller.email),
                    titleTextStyle: textTheme.titleMedium,
                    subtitleTextStyle: textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
