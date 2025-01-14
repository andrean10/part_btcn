import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class InformationController extends GetxController {
  // late final InitController _initC;
  late final WebViewController webC;

  final progressLoading = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    // if (Get.isRegistered<InitController>()) {
    //   _initC = Get.find<InitController>();
    // }

    if (GetPlatform.isMobile) {
      _initWeb();
    }
  }

  void _initWeb() {
    webC = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) => progressLoading.value = progress,
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            return NavigationDecision.prevent;

            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   return NavigationDecision.prevent;
            // }
            // return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse('https://bctn.co.id/about-us'));
  }
}
