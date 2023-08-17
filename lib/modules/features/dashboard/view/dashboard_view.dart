import 'package:coffee_app/configs/theme/colors.dart';
import 'package:coffee_app/constants/core/asset_const.dart';
import 'package:coffee_app/modules/features/dashboard/controllers/dashboard_controller.dart';
import 'package:coffee_app/modules/features/home/view/ui/home_view.dart';
import 'package:coffee_app/modules/features/order/view/ui/order_view.dart';
import 'package:coffee_app/modules/features/profile/view/ui/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: DashboardController.to.tabIndex.value,
          children: [
            HomeView(),
            OrderView(),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        child: Obx(
          () => BottomNavigationBar(
            onTap: DashboardController.to.changeTabIndex,
            currentIndex: DashboardController.to.tabIndex.value,
            backgroundColor: AppColor.darkColor2,
            selectedLabelStyle: Get.textTheme.labelSmall,
            unselectedLabelStyle: Get.textTheme.labelSmall,
            selectedItemColor: Colors.white,
            unselectedItemColor: AppColor.greyColor2,
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.r),
                  child: SvgPicture.asset(
                    AssetConst.iconHome,
                    color: AppColor.greyColor2,
                    height: 27.r,
                    width: 27.r,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5.r),
                  child: SvgPicture.asset(
                    AssetConst.iconHome,
                    color: Colors.white,
                    height: 27.r,
                    width: 27.r,
                  ),
                ),
                label: 'Home'.tr,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.r),
                  child: SvgPicture.asset(
                    AssetConst.iconOrder,
                    color: AppColor.greyColor2,
                    height: 27.r,
                    width: 27.r,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5.r),
                  child: SvgPicture.asset(
                    AssetConst.iconOrder,
                    color: Colors.white,
                    height: 27.r,
                    width: 27.r,
                  ),
                ),
                label: 'Order'.tr,
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(bottom: 5.r),
                  child: SvgPicture.asset(
                    AssetConst.iconProfile,
                    color: AppColor.greyColor2,
                    height: 27.r,
                    width: 27.r,
                  ),
                ),
                activeIcon: Padding(
                  padding: EdgeInsets.only(bottom: 5.r),
                  child: SvgPicture.asset(
                    AssetConst.iconProfile,
                    color: Colors.white,
                    height: 27.r,
                    width: 27.r,
                  ),
                ),
                label: 'Profile'.tr,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'package:coffee_app/modules/features/login/controllers/login_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class DashboardView extends StatelessWidget {
//   DashboardView({super.key});

//   final loginController = Get.put(LoginController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Text('Dashboard Page'),
//         ),
//       ),
//       floatingActionButton: Container(
//         margin: const EdgeInsets.only(bottom: 20),
//         width: 300,
//         child: ElevatedButton(
//           onPressed: () {
//             loginController.logout();
//           },
//           child: Text(
//             'Logout',
//           ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
