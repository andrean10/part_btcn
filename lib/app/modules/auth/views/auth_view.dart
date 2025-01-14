import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:part_btcn/app/modules/widgets/buttons/buttons.dart';

import '../../../../shared/shared_theme.dart';
import '../../../../utils/constants_assets.dart';
import '../../../routes/app_pages.dart';

class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = context.mediaQuerySize;
    final textTheme = context.textTheme;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(
              ConstantsAssets.imgSplash,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              frameBuilder: (context, child, frame, wasSynchronouslyLoaded) =>
                  Opacity(
                opacity: 0.7,
                child: child,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 38),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AutoSizeText(
                    'The best application for purchasing your parts',
                    style: textTheme.displayMedium?.copyWith(
                      fontWeight: SharedTheme.semiBold,
                    ),
                  ),
                  SizedBox(
                    width: size.height / 2,
                    child: Buttons.filledTonal(
                      width: double.infinity,
                      onPressed: () => Get.offAllNamed(Routes.LOGIN),
                      child: const Text('Masuk'),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
