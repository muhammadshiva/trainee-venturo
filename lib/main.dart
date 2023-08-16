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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
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
