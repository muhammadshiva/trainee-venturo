import 'dart:convert';

import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/cart_item.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:dio/dio.dart';

class OrderRepository {
  OrderRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<Response?> add(CartRequest cartReq) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.post(
        ApiConst.addOrder,
        data: json.encode(cartReq.toMap()),
      );

      return response;
    } on DioError {
      return null;
    }
  }
}
