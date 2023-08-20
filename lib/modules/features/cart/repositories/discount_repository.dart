import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/discount.dart';
import 'package:coffee_app/modules/models/user.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class DiscountRepository {
  DiscountRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<ListDiscountResponse> getAll() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.get('${ApiConst.allDiscountPerUser}/${user.idUser}');

      return ListDiscountResponse.fromJson(response.data);
    } on DioError {
      return ListDiscountResponse(status_code: 500, message: 'Server error'.tr);
    }
  }
}
