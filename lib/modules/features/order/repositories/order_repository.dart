import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/order.dart';
import 'package:coffee_app/modules/models/user.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:dio/dio.dart';

class OrderRepository {
  OrderRepository._();

  /// Memanggil API untuk mendapatkan semua order aktif
  static Future<ListOrderResponse> getOnGoing() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.get('${ApiConst.onGoingOrder}/${user.idUser}');

      return ListOrderResponse.fromJson(response.data);
    } on DioError {
      return const ListOrderResponse(status_code: 500);
    }
  }

  /// Memanggil API untuk mendapatkan semua riwayat order
  static Future<ListOrderResponse> getHistory() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.post('${ApiConst.historyOrder}/${user.idUser}');

      if (response.data['status_code'] == 200) {
        response.data['data'] = response.data['data']['listData'];
      }

      return ListOrderResponse.fromJson(response.data);
    } on DioError {
      return const ListOrderResponse(status_code: 500);
    }
  }

  /// Memanggil API untuk mendapatkan order berdasarkan ID
  static Future<OrderResponse> getFromId(int id) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.get('${ApiConst.detailOrder}/$id');

      return OrderResponse.fromJson(response.data);
    } on DioError {
      return const OrderResponse(status_code: 500);
    }
  }

  /// Memanggil API untuk membatalkan pesanan
  static Future<int> cancel(int id) async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var response = await dio.post('${ApiConst.cancelOrder}/$id');

      return response.data['status_code'];
    } on DioError {
      return 500;
    }
  }
}
