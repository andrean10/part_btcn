import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../controllers/information_controller.dart';

class InformationView extends GetView<InformationController> {
  const InformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informasi'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Obx(
            () => Visibility(
              visible: controller.progressLoading.value < 100,
              child: LinearProgressIndicator(
                value: controller.progressLoading.value / 100,
                backgroundColor: Colors.transparent,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ),
          ),
          WebViewWidget(controller: controller.webC),
        ],
      ),
    );
  }
}
