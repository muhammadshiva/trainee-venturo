import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/user.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:dio/dio.dart';

class UserRepository {
  UserRepository._();

  /// Memanggil API untuk mendapatkan user berdasarkan ID
  static Future<UserResponse> get() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.get('${ApiConst.detailUser}/${user.idUser}');

      return UserResponse.fromJson(response.data);
    } on DioError {
      return const UserResponse(statusCode: 500);
    }
  }

  /// Memanggil API untuk mengubah data user
  static Future<UserResponse> update(Map<String, String> data) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.post(
        '${ApiConst.updateUser}/${user.idUser}',
        data: data,
      );

      return UserResponse.fromJson(response.data);
    } on DioError {
      return const UserResponse(statusCode: 500);
    }
  }

  /// Memanggil API untuk mengubah data foto user
  static Future<UserResponse> updatePhoto(String photo) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.post(
        '${ApiConst.updateUserPhoto}/${user.idUser}',
        data: {'image': photo},
      );

      return UserResponse.fromJson(response.data);
    } on DioError {
      return const UserResponse(statusCode: 500);
    }
  }

  /// Memanggil API untuk mengubah data KTP user
  static Future<UserResponse> updateKTP(String photo) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.post(
        '${ApiConst.updateUserKTP}/${user.idUser}',
        data: {'image': photo},
      );

      return UserResponse.fromJson(response.data);
    } on DioError {
      return const UserResponse(statusCode: 500);
    }
  }
}
