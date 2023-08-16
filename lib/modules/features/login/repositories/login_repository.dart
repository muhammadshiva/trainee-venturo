import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/user.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class LoginRepository {
  LoginRepository._();

  static final Dio _dio = ApiServices.dioCall();

  /// Call API for login using email and password
  static Future<UserResponse> getUser(String email, String password) async {
    try {
      /// Memanggil API login dengan method POST
      var response = await _dio.post(ApiConst.login, data: {
        'email': email,
        'password': password,
      });

      return UserResponse.fromLoginJson(response.data);
    } on DioError {
      return UserResponse(statusCode: 500, message: 'Server error'.tr);
    }
  }
}
