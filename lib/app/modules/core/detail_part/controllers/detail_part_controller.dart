import 'package:get/get.dart';
import 'package:part_btcn/app/modules/core/init/controllers/init_controller.dart';
import 'package:part_btcn/app/modules/widgets/snackbar/snackbar.dart';

import '../../../../routes/app_pages.dart';

class DetailPartController extends GetxController {
  late final InitController _initC;

  final images = [
    "https://ryahuqeeaejuymakofdj.supabase.co/storage/v1/object/sign/btcn/images/40C0441P01%20(1).jpeg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJidGNuL2ltYWdlcy80MEMwNDQxUDAxICgxKS5qcGVnIiwiaWF0IjoxNzMzOTk4ODkwLCJleHAiOjE3NjU1MzQ4OTB9.D4vBol18h0dnV3HSzu8rohJoCVirH4GEEfIiqGLIDNs&t=2024-12-12T10%3A21%3A30.628Z",
    "https://ryahuqeeaejuymakofdj.supabase.co/storage/v1/object/sign/btcn/images/40C0441P01%20(2).jpeg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJidGNuL2ltYWdlcy80MEMwNDQxUDAxICgyKS5qcGVnIiwiaWF0IjoxNzMzOTk5MDA4LCJleHAiOjE3NjU1MzUwMDh9.i46h8Jbn007FRwasyWYldMBdmsohI1gAUEjcBiX1Rm0&t=2024-12-12T10%3A23%3A28.595Z",
    "https://ryahuqeeaejuymakofdj.supabase.co/storage/v1/object/sign/btcn/images/40C0441P01%20(2).jpeg?token=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1cmwiOiJidGNuL2ltYWdlcy80MEMwNDQxUDAxICgyKS5qcGVnIiwiaWF0IjoxNzMzOTk5MDIzLCJleHAiOjE3NjU1MzUwMjN9.ZEw4B130WdGo3oRZuwwFfD3qOD3Gh92z60VrlkqPmW4&t=2024-12-12T10%3A23%3A42.884Z",
  ];

  final carts = RxList<String>.empty();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }
  }

  // void moveToReviews() => Get.toNamed(Routes.REV)

  void checkout() => Get.toNamed(Routes.CHECKOUT);

  void moveToCart() => Get.toNamed(Routes.CART);

  void moveToChat() => Get.toNamed(Routes.CHAT);

  void addToCart() {
    carts.add('Test');
    Snackbar.success(
      context: Get.context!,
      content: 'Berhasil menambahkan ke keranjang',
    );
  }
}
