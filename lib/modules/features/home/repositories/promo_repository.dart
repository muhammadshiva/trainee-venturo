import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/promo.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class PromoRepository {
  PromoRepository._();

  /// Memanggil API untuk mendapatkan semua promo
  static Future<ListPromoResponse> getAllByUser() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.get(ApiConst.allPromo);

      return ListPromoResponse.fromJson(response.data);
    } on DioError catch (e) {
      Sentry.captureException(e);
      return ListPromoResponse(statusCode: 500, message: 'Server error'.tr);
    }
  }
}
