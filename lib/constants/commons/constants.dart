import 'package:flutter/material.dart';

class AppConst {
  // Ensures that this class cannot be instantiated
  AppConst._();

  // App information
  static const String appName = 'Java Code App';
  static const Size appDesignSize = Size(428, 926);
  static const String appLink = 'https://promo.trainee.landa.id';
  static const String appDeepLink = 'landa://javacode.app';
  static const String appVersion = '1.0.0';
  static const String firebaseCloudMessagingKey =
      'exCGEA6WQg2IY0A55lwWM2:APA91bGZgAze0QPHNueGZS1Rot94v2dtYLxl_SV9GGOGs4ChA840SRTFUM36idgT5LNm8ud2WQuUooD_VzkWwAHP831wOg4YsiPF1zWajjPqwpvfHfjU2PwqV--FrpXZ4wjdexck8Roe';

  // Location information
  static const double locationLatitude = -7.877427;
  static const double locationLongitude = 112.6698827;
  static const double maximumDistance = 100;

// Menu information
  static const String defaultMenuPhoto =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';
  static const String foodCategory = 'makanan';
  static const String drinkCategory = 'minuman';

  /// Informasi kondisi
  static const String fingerprint = 'fingerprint';
  static const String pin = 'pin';
}
