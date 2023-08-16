import 'package:get/get.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  @override
  void onInit() async {
    super.onInit();

    // Delay 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Access Login Page
    Get.toNamed('/login');
  }
}
