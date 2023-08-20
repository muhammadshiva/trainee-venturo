import 'package:coffee_app/configs/theme/colors.dart';
import 'package:coffee_app/constants/commons/constants.dart';
import 'package:coffee_app/constants/core/asset_const.dart';
import 'package:coffee_app/modules/features/login/view/components/divider_with_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class FingerprintDialog extends StatelessWidget {
  const FingerprintDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Judul
          Text(
            'Verify order'.tr,
            style: Get.textTheme.headlineMedium,
          ),

          /// Subjudul
          Text(
            'Press your fingerprint'.tr,
            style: Get.textTheme.bodySmall!.copyWith(color: AppColor.greyColor2),
          ),
          30.verticalSpacingRadius,

          /// Icon fingerprint
          GestureDetector(
            child: SvgPicture.asset(AssetConst.iconFingerprint),
            onTap: () => Get.back<String>(result: AppConst.fingerprint),
          ),
          30.verticalSpacingRadius,
          DividerWithText('or'.tr),

          /// Opsi menggunakan PIN
          TextButton(
            onPressed: () => Get.back<String>(result: AppConst.pin),
            child: Text(
              'Verify using PIN code'.tr,
              style: Get.textTheme.titleSmall!.copyWith(color: AppColor.blueColor),
            ),
          ),
        ],
      ),
    );
  }
}
