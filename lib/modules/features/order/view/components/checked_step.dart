import 'package:coffee_app/configs/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckedStep extends StatelessWidget {
  const CheckedStep({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        color: AppColor.blueColor,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 8,
            spreadRadius: -1,
            color: Colors.black.withOpacity(0.5),
          ),
        ],
      ),
      child: Icon(
        Icons.check,
        color: Colors.white,
        size: 30.r,
      ),
    );
  }
}
