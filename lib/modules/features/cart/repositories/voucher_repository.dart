import 'package:coffee_app/constants/core/api_const.dart';
import 'package:coffee_app/modules/models/user.dart';
import 'package:coffee_app/modules/models/voucher.dart';
import 'package:coffee_app/utils/services/api_services.dart';
import 'package:coffee_app/utils/services/local_db_services.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

class VoucherRepository {
  VoucherRepository._();

  /// Memanggil API untuk mendapatkan semua menu
  static Future<ListVoucherResponse> getAll() async {
    try {
      var dio = ApiServices.dioCall(token: await LocalDBServices.getToken());
      var user = await LocalDBServices.getUser() as User;
      var response = await dio.get('${ApiConst.allVoucherPerUser}/${user.idUser}');

      return ListVoucherResponse.fromJson(response.data);
    } on DioError {
      return ListVoucherResponse(status_code: 500, message: 'Server error'.tr);
    }
  }
}
