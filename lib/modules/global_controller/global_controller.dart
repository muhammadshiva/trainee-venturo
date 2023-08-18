import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/shared/widgets/network_error_view.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uni_links/uni_links.dart';

class GlobalController extends GetxController {
  static GlobalController get to => Get.find();

  /// Instance from connectivity_plus
  final Connectivity _connectivity = Connectivity();

  /// Internet status
  RxBool internetStatus = RxBool(true);

  @override
  void onInit() {
    super.onInit();

    // Check connectivity
    checkConnectivity();

    // Listen connectivity changes
    _connectivity.onConnectivityChanged.listen(_updateConnectivity);
  }

  /// To check internet connection
  void checkConnectivity() {
    _connectivity.checkConnectivity().then(_updateConnectivity);

    /// Inisialisasi uni links
    initUniLinks();
  }

  /// To update internet connection
  void _updateConnectivity(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:

        /// if connection success
        internetStatus.value = true;
        Get.back();
        break;
      default:

        /// If connection failed
        internetStatus.value = false;
        if (Get.currentRoute != AppRoutes.splashView) {
          showAlert();
        }
        break;
    }
  }

  /// Show alert internet
  Future<void> showAlert() async {
    await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const NetworkErrorView(),
      barrierDismissible: false,
    );
  }

  Future<void> initUniLinks() async {
    /// Listen dari perubahan uni link
    uriLinkStream.listen(processUniLinks);
  }

  void processUniLinks(Uri? uri) async {
    if (uri != null && uri.queryParameters['id_promo'] != null) {
      /// Mendapatkan user dan token dari local DB service
      var user = await LocalDBServices.getUser();
      var token = await LocalDBServices.getToken();

      if (user != null && token != null) {
        /// Navigasi ke detail promo jika sudah login
        await Get.toNamed(
          AppRoutes.detailPromoView,
          arguments: int.parse(uri.queryParameters['id_promo']!),
        );
      }
    }
  }
}
