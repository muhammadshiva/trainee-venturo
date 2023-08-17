import 'package:app_settings/app_settings.dart';
import 'package:coffee_app/configs/theme/colors.dart';
import 'package:coffee_app/constants/core/asset_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ActivateLocationView extends StatefulWidget {
  const ActivateLocationView({
    super.key,
    required this.statusLocation,
  });

  final String statusLocation;

  @override
  State<ActivateLocationView> createState() => _ActivateLocationViewState();
}

class _ActivateLocationViewState extends State<ActivateLocationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AssetConst.bgPattern2),
              fit: BoxFit.fitHeight,
              alignment: Alignment.center,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 30.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AssetConst.activateLocation),
              const SizedBox(height: 10),
              Text(
                'Aktifkan lokasimu',
                style: GoogleFonts.montserrat().copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              widget.statusLocation == 'loading'
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: () => AppSettings.openAppSettings(type: AppSettingsType.location),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        elevation: 2,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.settings,
                            color: AppColor.darkColor,
                          ),
                          16.horizontalSpaceRadius,
                          Text(
                            'Open settings'.tr,
                            style: Get.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
