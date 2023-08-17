// Location services to get location information
import 'package:coffee_app/configs/localizations/localization.dart';
import 'package:coffee_app/constants/commons/constants.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class LocationServices {
  // Ensures this class cannot be instantiated
  LocationServices._();

  static Stream<ServiceStatus> streamService = Geolocator.getServiceStatusStream();

  // Get location information
  static Future<LocationResult> getCurrentPosition() async {
    // Is location service active ?
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Otherwise send an error message
      return LocationResult.error(message: 'Location service not enabled'.tr);
    }

    // Check location permission
    LocationPermission permission = await Geolocator.checkPermission();

    // Is permission denied
    if (permission == LocationPermission.denied) {
      // If isn't, ask permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return LocationResult.error(message: 'Location permission not granted'.tr);
      }
    }

    /// Is location permission denied forever
    if (permission == LocationPermission.deniedForever) {
      /// If location permission is denied forever, sends an error message
      return LocationResult.error(
        message: 'Location permission not granted forever'.tr,
      );
    }

    /// If location permission is granted, fetch location
    late Position position;
    try {
      position = await Geolocator.getCurrentPosition();
    } catch (e, st) {
      // FirebaseCrashlytics.instance.recordError(e, st);
      return LocationResult.error(message: 'Location service not enabled'.tr);
    }

    // Get location information in meters
    double distanceInMeters = Geolocator.distanceBetween(
      position.latitude,
      position.longitude,
      AppConst.locationLatitude,
      AppConst.locationLongitude,
    );

    /// Is the location close to the Java Code location within the specified radius?
    if (distanceInMeters > AppConst.maximumDistance) {
      // Otherwise, send an error message
      return LocationResult.error(message: 'Distance not close'.tr);
    }

    // Retrieve location information
    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
      localeIdentifier: Localization.currentLocale.toString(),
    );

    if (placemarks.isEmpty) {
      /// If there is no location information, send an error message
      return LocationResult.error(message: 'Unknown location'.tr);
    }

    /// If there is location information, send location information
    return LocationResult.success(
      position: position,
      address: [
        placemarks.first.name,
        placemarks.first.subLocality,
        placemarks.first.locality,
        placemarks.first.administrativeArea,
        placemarks.first.postalCode,
        placemarks.first.country,
      ].where((e) => e != null).join(', '),
    );
  }
}

class LocationResult {
  final bool success;
  final Position? position;
  final String? address;
  final String? message;

  LocationResult({
    required this.success,
    this.position,
    this.address,
    this.message,
  });

  factory LocationResult.success({required Position position, required String address}) {
    return LocationResult(
      success: true,
      position: position,
      address: address,
    );
  }

  factory LocationResult.error({required String message}) {
    return LocationResult(
      success: false,
      message: message,
    );
  }
}
