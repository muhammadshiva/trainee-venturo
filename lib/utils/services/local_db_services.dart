import 'dart:convert';

import 'package:coffee_app/modules/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Local DB Service using shared preferences
class LocalDBServices {
  // Ensures that this class cannot be instantiated
  LocalDBServices._();

  // Save user data to shared preferences
  static Future<void> setUser(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(user.toMap()));
  }

  // Get user from shared preference
  static Future<User?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? user = prefs.getString('user');
    if (user == null) {
      return null;
    } else {
      return User.fromJson(json.decode(user));
    }
  }

  // Delete user data from shared preference
  static Future<void> clearUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
  }

  // Save token data to shared preference
  static Future<void> setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Get token data from shared preferences
  static Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // Delete token data from shared preferences
  static Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
