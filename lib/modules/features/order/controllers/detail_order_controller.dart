import 'dart:async';

import 'package:coffee_app/modules/features/order/controllers/order_controller.dart';
import 'package:coffee_app/modules/features/order/repositories/order_repository.dart';
import 'package:coffee_app/modules/features/order/view/components/cancel_dialog.dart';
import 'package:coffee_app/modules/models/detail_order.dart';
import 'package:coffee_app/modules/models/order.dart';
import 'package:coffee_app/shared/customs/error_snack_bar.dart';
import 'package:coffee_app/shared/customs/success_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailOrderController extends GetxController {
  static DetailOrderController get to => Get.find();

  /// Data pesanan
  RxString status = RxString('loading');
  Rxn<Order> order = Rxn();
  Timer? timer;

  @override
  void onInit() {
    super.onInit();

    /// Ambil data pesanan, dan jika berhasil, ambil data detail pesanan
    /// Atur timer untuk mengambil data detail pesanan secara berkala
    fetch().then((_) {
      timer = Timer.periodic(const Duration(seconds: 10), (_) => fetch());
    });
  }

  @override
  void onClose() {
    /// Hentikan timer
    timer?.cancel();

    super.onClose();
  }

  /// Ambil data pesanan
  Future<void> fetch() async {
    if (order.value != null) {
      status.value = 'update';
      await fetchOrderFromId(order.value!.id_order);
    } else if (Get.arguments is int) {
      status.value = 'loading';
      await fetchOrderFromId(Get.arguments as int);
    } else if (Get.arguments is Order) {
      order.value = Get.arguments as Order;
      status.value = 'update';
      await fetchOrderFromId(order.value!.id_order);
    }
  }

  /// Ambil data pesanan dari id pesanan
  Future<void> fetchOrderFromId(int id) async {
    OrderResponse orderRes = await OrderRepository.getFromId(id);

    if (orderRes.status_code == 200) {
      status.value = 'success';
      order.value = null;
      order.value = orderRes.data;
    } else if (orderRes.status_code == 204) {
      status.value = 'empty';
    } else {
      status.value = 'error';
    }
  }

  Future<void> cancel() async {
    final result = await Get.defaultDialog(
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      content: const CancelDialog(),
    );

    if (result == true) {
      /// Fetch api batal order
      final statusCode = await OrderRepository.cancel(order.value!.id_order);

      if (statusCode == 200) {
        /// Fetch data baru
        await fetch();

        /// Tampilkan snackbar sukses
        Get.showSnackbar(
          SuccessSnackBar(
            title: 'Success!'.tr,
            message: 'Your order has been canceled'.tr,
          ),
        );

        /// Reload tampilan daftar order
        OrderController.to.fetchOnGoing();
        OrderController.to.fetchHistory();
      } else {
        /// Tampilkan snackbar error tidak diketahui
        Get.showSnackbar(ErrorSnackBar(
          title: 'Something went wrong'.tr,
          message: 'Unknown error'.tr,
        ));
      }
    }
  }

  /// Getter for food items
  List<DetailOrder> get foodItems => order.value != null ? order.value!.menu.where((e) => e.isFood).toList() : [];

  /// Getter for drink items
  List<DetailOrder> get drinkItems => order.value != null ? order.value!.menu.where((e) => e.isDrink).toList() : [];
}
