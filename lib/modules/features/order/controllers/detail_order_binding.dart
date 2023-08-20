import 'package:coffee_app/modules/features/order/controllers/detail_order_controller.dart';
import 'package:get/get.dart';

class DetailOrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailOrderController());
  }
}
