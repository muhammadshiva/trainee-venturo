import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/configs/routes/app_routes.dart';
import 'package:coffee_app/configs/theme/colors.dart';
import 'package:coffee_app/constants/core/asset_const.dart';
import 'package:coffee_app/modules/features/cart/controllers/cart_controller.dart';
import 'package:coffee_app/modules/models/voucher.dart';
import 'package:coffee_app/shared/styles/shapes.dart';
import 'package:coffee_app/shared/widgets/danger_button.dart';
import 'package:coffee_app/shared/widgets/primary_button.dart';
import 'package:coffee_app/shared/widgets/tile_option.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DetailVoucherView extends StatelessWidget {
  const DetailVoucherView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Voucher voucher = Get.arguments as Voucher;

    return Scaffold(
      backgroundColor: AppColor.lightColor3,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 30.r,
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
          onPressed: () => Get.back(closeOverlays: true),
        ),
        centerTitle: true,
        title: Text('Detail voucher'.tr, style: Get.textTheme.titleMedium),
        shape: CustomShape.bottomRoundedShape,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Hero(
              tag: 'voucher-image-${voucher.id_voucher}',
              child: CachedNetworkImage(
                imageUrl: voucher.info_voucher,
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 25.r, vertical: 45.r),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    voucher.nama,
                    style: Get.textTheme.titleMedium!.copyWith(color: AppColor.blueColor),
                  ),
                  Conditional.single(
                    context: context,
                    conditionBuilder: (context) => voucher.catatan != null,
                    widgetBuilder: (context) => HtmlWidget(
                      voucher.catatan!,
                    ),
                    fallbackBuilder: (context) => const SizedBox(),
                  ),
                  40.verticalSpacingRadius,
                  Divider(color: AppColor.darkColor2.withOpacity(0.25), height: 1),
                  TileOption(
                    icon: AssetConst.iconDate,
                    title: 'Valid date'.tr,
                    message:
                        '${DateFormat('dd/MM/yyyy').format(voucher.periode_mulai)} - ${DateFormat('dd/MM/yyyy').format(voucher.periode_selesai)}',
                    titleStyle: Get.textTheme.headlineSmall,
                  ),
                  Divider(color: AppColor.darkColor2.withOpacity(0.25), height: 2.r),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 22.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: -1,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Conditional.single(
            context: context,
            conditionBuilder: (context) => voucher != CartController.to.selectedVoucher.value,
            widgetBuilder: (context) => PrimaryButton(
              text: 'Use voucher'.tr,
              onPressed: () {
                CartController.to.setVoucher(voucher);
                Get.until(ModalRoute.withName(AppRoutes.cartView));
              },
            ),
            fallbackBuilder: (context) => DangerButton(
              text: 'Use voucher later'.tr,
              onPressed: () {
                CartController.to.setVoucher(null);
                Get.until(ModalRoute.withName(AppRoutes.cartView));
              },
            ),
          ),
        ),
      ),
    );
  }
}
