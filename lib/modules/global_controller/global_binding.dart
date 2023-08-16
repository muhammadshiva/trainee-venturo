import 'package:coffee_app/modules/global_controller/global_controller.dart';
import 'package:get/get.dart';

class GlobalBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(GlobalController(), permanent: true);
  }
}
