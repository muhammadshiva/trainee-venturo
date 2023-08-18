import 'package:flutter/material.dart';

class AppConst {
  // Ensures that this class cannot be instantiated
  AppConst._();

  // App information
  static const String appName = 'Java Code App';
  static const Size appDesignSize = Size(428, 926);
  static const String appLink = 'https://promo.trainee.landa.id';
  static const String appDeepLink = 'landa://javacode.app';

  // Location information
  static const double locationLatitude = -7.877427;
  static const double locationLongitude = 112.6698827;
  static const double maximumDistance = 100;

// Menu information
  static const String defaultMenuPhoto =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';
  static const String foodCategory = 'makanan';
  static const String drinkCategory = 'minuman';
}
