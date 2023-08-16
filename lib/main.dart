import 'package:coffee_app/configs/pages/app_pages.dart';
import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/configs/theme/light_theme.dart';
import 'package:coffee_app/constants/commons/constants.dart';
import 'package:coffee_app/firebase_options.dart';
import 'package:coffee_app/modules/global_controller/global_binding.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://499d9154a151839d6a545df7c74eb1aa@o4505672461320192.ingest.sentry.io/4505715101794304';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
    appRunner: () => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Initialize Firebase Analytics
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {
    // Firebase Analytics Usage
    analytics.setCurrentScreen(
      screenName: 'Initial Screen',
      screenClassOverride: 'Trainee',
    );

    // Screen Util Init based on application design size
    return ScreenUtilInit(
      designSize: AppConst.appDesignSize,
      builder: (context, child) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        initialBinding: GlobalBinding(),
        title: AppConst.appName,
        initialRoute: AppRoutes.splashView,
        getPages: AppPages.pages(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
