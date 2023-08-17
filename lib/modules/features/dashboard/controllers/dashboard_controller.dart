import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/modules/features/dashboard/view/activate_location_view.dart';
import 'package:coffee_app/modules/features/dashboard/view/get_location_view.dart';
import 'package:coffee_app/utils/services/location_services.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  static DashboardController get to => Get.find<DashboardController>();

  @override
  void onReady() {
    super.onReady();

    // Look for location
    getLocation();
    LocationServices.streamService.listen((status) => getLocation());
  }

  // Navigation bar
  RxInt tabIndex = RxInt(0);

  // Change tab index
  void changeTabIndex(int index) {
    tabIndex.value = index;
  }

  // Location
  RxString statusLocation = RxString('loading');
  RxString messageLocation = RxString('');
  Rxn<Position> position = Rxn<Position>();
  RxnString address = RxnString();

  /// Get current location if location not exists
  Future<void> getLocation() async {
    // Get current location result
    final locationResult = await LocationServices.getCurrentPosition();

    if (Get.isDialogOpen == false) {
      if (locationResult.message == "Location service not enabled") {
        print('Location service not enabled');
        Get.dialog(
          ActivateLocationView(
            statusLocation: statusLocation.value,
          ),
          barrierDismissible: false,
        );
      } else {
        Get.dialog(
          const GetLocationView(),
          barrierDismissible: false,
        );
      }
    }

    try {
      /// Mendapatkan lokasi saat ini
      statusLocation.value = 'loading';
      print('Loading ....');

      if (locationResult.success) {
        /// Jika jarak lokasi cukup dekat, dapatkan informasi alamat
        position.value = locationResult.position;
        address.value = locationResult.address;
        statusLocation.value = 'success';

        await Future.delayed(const Duration(seconds: 1));
        Get.until(ModalRoute.withName(AppRoutes.dashboardView));
        // Get.toNamed(AppRoutes.dashboardView);
      } else {
        /// Jika jarak lokasi tidak cukup dekat, tampilkan pesan
        statusLocation.value = 'error';
        messageLocation.value = locationResult.message!;
      }
    } catch (e) {
      /// Jika terjadi kesalahan server
      statusLocation.value = 'error';
      messageLocation.value = 'Server error'.tr;
    }
  }
}
