import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffee_app/configs/theme/colors.dart';
import 'package:coffee_app/constants/commons/constants.dart';
import 'package:coffee_app/constants/core/asset_const.dart';
import 'package:coffee_app/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:coffee_app/shared/styles/shapes.dart';
import 'package:coffee_app/shared/widgets/danger_button.dart';
import 'package:coffee_app/shared/widgets/primary_button.dart';
import 'package:coffee_app/shared/widgets/quantity_counter.dart';
import 'package:coffee_app/shared/widgets/rect_shimmer.dart';
import 'package:coffee_app/shared/widgets/tile_option.dart';
import 'package:coffee_app/utils/extensions/currency_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_conditional_rendering/flutter_conditional_rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DetailMenuView extends StatelessWidget {
  const DetailMenuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        leading: IconButton(
          splashRadius: 30.r,
          icon: Icon(Icons.chevron_left, color: Colors.black, size: 36.r),
          onPressed: () => Get.back(closeOverlays: true),
        ),
        centerTitle: true,
        title: Text('Detail menu'.tr, style: Get.textTheme.titleMedium),
        shape: CustomShape.bottomRoundedShape,
      ),
      backgroundColor: AppColor.lightColor3,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(25.r),
              child: Center(
                child: Hero(
                  tag: 'menu-${DetailMenuController.to.menu.value!.idMenu}',
                  child: CachedNetworkImage(
                    imageUrl: DetailMenuController.to.menu.value!.foto,
                    height: 181.r,
                    width: 234.r,
                    fit: BoxFit.contain,
                    errorWidget: (context, _, __) => CachedNetworkImage(
                      imageUrl: AppConst.defaultMenuPhoto,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 22.r, vertical: 45.r),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          DetailMenuController.to.menu.value!.nama,
                          style: Get.textTheme.titleMedium!.copyWith(color: AppColor.blueColor),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      10.horizontalSpaceRadius,
                      Obx(
                        () => QuantityCounter(
                          quantity: DetailMenuController.to.quantity.value,
                          onIncrement: DetailMenuController.to.onIncrement,
                          onDecrement: DetailMenuController.to.isExistsInCart.value || DetailMenuController.to.quantity > 1
                              ? DetailMenuController.to.onDecrement
                              : null,
                        ),
                      ),
                    ],
                  ),
                  14.verticalSpacingRadius,
                  Text(
                    DetailMenuController.to.menu.value!.deskripsi,
                    style: Get.textTheme.labelMedium,
                    textAlign: TextAlign.left,
                  ),
                  40.verticalSpacingRadius,
                  Divider(color: AppColor.darkColor2.withOpacity(0.25), height: 2.r),
                  Obx(
                    () => TileOption(
                      icon: AssetConst.iconPrice,
                      title: 'Price'.tr,
                      message: DetailMenuController.to.cartItem.price.toRupiah(),
                      messageStyle: Get.textTheme.headlineSmall!.copyWith(color: AppColor.blueColor),
                    ),
                  ),
                  Obx(
                    () => ConditionalSwitch.single(
                      context: context,
                      valueBuilder: (context) => DetailMenuController.to.statusLevels.value,
                      caseBuilders: {
                        'success': (context) => Wrap(
                              children: [
                                Divider(
                                  color: AppColor.darkColor2.withOpacity(0.25),
                                  height: 2.r,
                                ),
                                TileOption(
                                  icon: AssetConst.iconLevel,
                                  title: 'Level'.tr,
                                  message: DetailMenuController.to.selectedLevelText,
                                  onTap: DetailMenuController.to.openLevelBottomSheet,
                                ),
                              ],
                            ),
                        'loading': (context) => Wrap(
                              children: [
                                Divider(
                                  color: AppColor.darkColor2.withOpacity(0.25),
                                  height: 2.r,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.r),
                                  child: RectShimmer(height: 32.r),
                                ),
                              ],
                            ),
                      },
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                  Obx(
                    () => ConditionalSwitch.single(
                      context: context,
                      valueBuilder: (context) => DetailMenuController.to.statusLevels.value,
                      caseBuilders: {
                        'success': (context) => Wrap(
                              children: [
                                Divider(
                                  color: AppColor.darkColor2.withOpacity(0.25),
                                  height: 2.r,
                                ),
                                TileOption(
                                  icon: AssetConst.iconTopping,
                                  title: 'Topping'.tr,
                                  message: DetailMenuController.to.selectedToppingsText,
                                  onTap: DetailMenuController.to.openToppingBottomSheet,
                                ),
                              ],
                            ),
                        'loading': (context) => Wrap(
                              children: [
                                Divider(
                                  color: AppColor.darkColor2.withOpacity(0.25),
                                  height: 2.r,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.r),
                                  child: RectShimmer(height: 32.r),
                                ),
                              ],
                            ),
                      },
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                  Divider(color: AppColor.darkColor2.withOpacity(0.25), height: 2.r),
                  Obx(
                    () => TileOption(
                      icon: AssetConst.iconEdit,
                      title: 'Note'.tr,
                      message: DetailMenuController.to.note.isNotEmpty ? DetailMenuController.to.note.value : 'Add note'.tr,
                      onTap: DetailMenuController.to.openNoteBottomSheet,
                    ),
                  ),
                  Divider(color: AppColor.darkColor2.withOpacity(0.25), height: 2.r),
                  40.verticalSpacingRadius,
                  Obx(
                    () => ConditionalSwitch.single(
                      context: context,
                      valueBuilder: (context) => DetailMenuController.to.status.value,
                      caseBuilders: {
                        'loading': (context) => RectShimmer(
                              height: 50.r,
                              radius: 30.r,
                            ),
                        'success': (context) => SizedBox(
                              width: double.infinity,
                              child: Conditional.single(
                                context: context,
                                conditionBuilder: (context) => DetailMenuController.to.quantity > 0,
                                widgetBuilder: (context) => PrimaryButton(
                                  text: DetailMenuController.to.isExistsInCart.value ? 'Update to order'.tr : 'Add to order'.tr,
                                  onPressed: DetailMenuController.to.addToCart,
                                ),
                                fallbackBuilder: (context) => DangerButton(
                                  text: 'Delete from order'.tr,
                                  onPressed: DetailMenuController.to.deleteFromCart,
                                ),
                              ),
                            ),
                      },
                      fallbackBuilder: (context) => const SizedBox(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
