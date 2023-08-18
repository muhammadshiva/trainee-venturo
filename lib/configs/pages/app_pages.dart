import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/modules/features/dashboard/controllers/dashboard_binding.dart';
import 'package:coffee_app/modules/features/dashboard/view/dashboard_view.dart';
import 'package:coffee_app/modules/features/login/controllers/login_binding.dart';
import 'package:coffee_app/modules/features/login/view/ui/login_view.dart';
import 'package:coffee_app/modules/features/menu/controllers/detail_menu_binding.dart';
import 'package:coffee_app/modules/features/menu/view/ui/detail_menu_view.dart';
import 'package:coffee_app/modules/features/promo/controllers/detail_promo_binding.dart';
import 'package:coffee_app/modules/features/promo/ui/detail_promo_view.dart';
import 'package:coffee_app/modules/features/splash/controllers/splash_binding.dart';
import 'package:coffee_app/modules/features/splash/view/ui/splash_view.dart';
import 'package:get/get.dart';

class AppPages {
  // Ensures that this class cannot be instantiated
  AppPages._();

  static List<GetPage> pages() {
    return [
      // Authentication
      GetPage(
        name: AppRoutes.splashView,
        page: () => SplashView(),
        binding: SplashBinding(),
      ),

      GetPage(
        name: AppRoutes.loginView,
        page: () => LoginView(),
        binding: LoginBinding(),
      ),

      // Dashboard
      GetPage(
        name: AppRoutes.dashboardView,
        page: () => DashboardView(),
        binding: DashboardBinding(),
      ),

      /// Menu dan Promo
      GetPage(
        name: AppRoutes.detailPromoView,
        page: () => DetailPromoView(),
        binding: DetailPromoBinding(),
      ),
      GetPage(
        name: AppRoutes.detailMenuView,
        page: () => DetailMenuView(),
        binding: DetailMenuBinding(),
      ),
    ];
  }
}
