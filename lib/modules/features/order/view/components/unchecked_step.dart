import 'package:coffee_app/configs/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UncheckedStep extends StatelessWidget {
  const UncheckedStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(6.r),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [],
      ),
      child: Icon(
        Icons.circle,
        color: AppColor.darkColor4,
        size: 18.r,
      ),
    );
  }
}
