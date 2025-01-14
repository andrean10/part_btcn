import 'package:get/get.dart';

import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/core/cart/bindings/cart_binding.dart';
import '../modules/core/cart/views/cart_view.dart';
import '../modules/core/checkout/bindings/checkout_binding.dart';
import '../modules/core/checkout/views/checkout_view.dart';
import '../modules/core/chat/bindings/chat_binding.dart';
import '../modules/core/chat/views/chat_view.dart';
import '../modules/core/home/bindings/home_binding.dart';
import '../modules/core/home/views/home_view.dart';
import '../modules/core/main/bindings/main_binding.dart';
import '../modules/core/main/views/main_view.dart';
import '../modules/core/profile/bindings/profile_binding.dart';
import '../modules/core/profile/views/profile_view.dart';
import '../modules/core/splash/bindings/splash_binding.dart';
import '../modules/core/splash/views/splash_view.dart';
import '../modules/core/detail_admin/bindings/detail_admin_binding.dart';
import '../modules/core/detail_admin/views/detail_admin_view.dart';
import '../modules/core/detail_chat/bindings/detail_chat_binding.dart';
import '../modules/core/detail_chat/views/detail_chat_view.dart';
import '../modules/core/detail_history/bindings/detail_history_binding.dart';
import '../modules/core/detail_history/views/detail_history_view.dart';
import '../modules/core/detail_part/bindings/detail_part_binding.dart';
import '../modules/core/detail_part/views/detail_part_view.dart';
import '../modules/core/history_order/bindings/history_order_binding.dart';
import '../modules/core/history_order/views/history_order_view.dart';
import '../modules/core/information/bindings/information_binding.dart';
import '../modules/core/information/views/information_view.dart';
import '../modules/core/payment/bindings/payment_binding.dart';
import '../modules/core/payment/views/payment_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => const AuthView(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.MAIN,
      page: () => const MainView(),
      binding: MainBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      // binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_ADMIN,
      page: () => const DetailAdminView(),
      binding: DetailAdminBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_CHAT,
      page: () => const DetailChatView(),
      binding: DetailChatBinding(),
    ),
    GetPage(
      name: _Paths.CART,
      page: () => const CartView(),
      binding: CartBinding(),
      fullscreenDialog: true,
    ),
    GetPage(
      name: _Paths.HISTORY_ORDER,
      page: () => const HistoryOrderView(),
      // binding: HistoryOrderBinding(),
    ),
    GetPage(
      name: _Paths.INFORMATION,
      page: () => const InformationView(),
      binding: InformationBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PART,
      page: () => const DetailPartView(),
      binding: DetailPartBinding(),
    ),
    GetPage(
      name: _Paths.CHECKOUT,
      page: () => const CheckoutView(),
      binding: CheckoutBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT,
      page: () => const PaymentView(),
      binding: PaymentBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_HISTORY,
      page: () => const DetailHistoryView(),
      binding: DetailHistoryBinding(),
    ),
  ];
}
