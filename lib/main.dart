import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'app/modules/core/init/bindings/init_binding.dart';
import 'app/routes/app_pages.dart';
import 'shared/shared_theme.dart';
import 'utils/constants_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: ConstantsStrings.appName,
      theme: SharedTheme.lightThemeMaterial,
      darkTheme: SharedTheme.darkThemeMaterial,
      themeMode: ThemeMode.system,
      initialBinding: InitBinding(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.cupertino,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'), //Indonesia
      ],
      debugShowCheckedModeBanner: false,
      enableLog: true,
    );
  }
}
