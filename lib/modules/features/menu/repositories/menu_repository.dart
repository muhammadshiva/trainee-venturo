import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/menu.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class MenuRepository {
  MenuRepository._();

  /// Memanggil API untuk mendapatkan menu berdasarkan id
  static Future<MenuResponse> getFromId(int idMenu) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.get('${ApiConst.detailMenu}/$idMenu');

      return MenuResponse.fromJson(response.data);
    } on DioError catch (e) {
      return MenuResponse(statusCode: 500, message: 'Server error'.tr);
    }
  }
}
