import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/menu.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class MenuRepository {
  MenuRepository._();

  // Call API to fetch all menu
  static Future<ListMenuResponse> getAll() async {
    try {
      var dio = ApiServices.dioCall(
        token: await LocalDBServices.getToken(),
      );

      var response = await dio.get(ApiConst.allMenu);

      return ListMenuResponse.fromJson(response.data);
    } on DioError catch (e) {
      Sentry.captureException(e);
      return ListMenuResponse(statusCode: 500, message: 'Server error'.tr);
    }
  }
}
