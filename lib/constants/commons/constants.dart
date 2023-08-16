import 'package:flutter/material.dart';

class AppConst {
  // Ensures that this class cannot be instantiated
  AppConst._();

  // App information

  // Location information
  static const double locationLatitude = -7.9423;
  static const double locationLongitude = 112.6230;
  static const double maximumDistance = 100;

// Menu information
  static const String defaultMenuPhoto =
      'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ac/No_image_available.svg/240px-No_image_available.svg.png';
  static const String foodCategory = 'makanan';
  static const String drinkCategory = 'minuman';
}
