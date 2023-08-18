import 'package:coffee_app/modules/features/promo/controllers/detail_promo_controller.dart';
import 'package:get/get.dart';

class DetailPromoBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DetailPromoController());
  }
}
