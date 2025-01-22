import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../../utils/constants_assets.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.asset(
              width: double.infinity,
              height: double.infinity,
              ConstantsAssets.imgSplash,
              fit: BoxFit.cover,
            ),
            Positioned(
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 72),
                child: SvgPicture.asset(ConstantsAssets.icLogoApp),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
