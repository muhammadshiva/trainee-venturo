import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  static SplashController get to => Get.find<SplashController>();

  @override
  void onInit() async {
    super.onInit();

    // Delay 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Mendapatkan user dan token dari local DB service
    var user = await LocalDBServices.getUser();
    var token = await LocalDBServices.getToken();

    // If there is login session
    if (user != null && token != null) {
      // Going to main page
      await Get.offAllNamed('/dashboard');
    } else {
      // if no session go to login page
      Get.offAllNamed('/login');
    }
  }
}
