import 'package:coffee_app/configs/pages/app_pages.dart';
import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/configs/theme/light_theme.dart';
import 'package:coffee_app/constants/commons/constants.dart';
import 'package:coffee_app/modules/global_controller/global_binding.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
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
