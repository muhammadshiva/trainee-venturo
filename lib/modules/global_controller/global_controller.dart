import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/shared/widgets/network_error_view.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
