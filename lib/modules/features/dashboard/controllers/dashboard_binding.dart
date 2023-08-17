import 'package:coffee_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:coffee_app/modules/features/home/controllers/home_controller.dart';
import 'package:coffee_app/modules/features/order/controllers/order_controller.dart';
import 'package:coffee_app/modules/features/profile/controllers/profile_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize dashboard controller
    Get.put(DashboardController());

    // Initialize cart controller

    /// Inisialisasi home, order, profile
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => OrderController());
    Get.lazyPut(() => ProfileController());
  }
}
