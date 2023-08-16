import 'package:coffee_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:get/get.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    // Initialize dashboard controller
    Get.put(DashboardController());
  }
}
