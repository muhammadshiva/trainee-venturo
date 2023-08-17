import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Class localization
class Localization extends Translations {
  /// Mengatur default locale
  static const locale = Locale('id', 'ID');

  /// Mengatur fallback locale
  static const fallbackLocale = Locale('en', 'US');

  /// Mengembalikan locale saat ini
  static Locale get currentLocale {
    return Get.locale ?? fallbackLocale;
  }

  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => throw UnimplementedError();
}
