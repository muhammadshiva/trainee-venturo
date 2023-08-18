import 'package:coffee_app/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:get/get.dart';

class DetailMenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailMenuController());
  }
}
