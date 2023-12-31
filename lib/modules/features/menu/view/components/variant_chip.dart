import 'package:coffee_app/configs/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class VariantChip extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool isSelected;

  const VariantChip({
    Key? key,
    required this.text,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(30.r),
      child: InkWell(
        onTap: onTap,
        child: Ink(
          padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 5.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: isSelected ? AppColor.blueColor : Colors.white,
            border: Border.all(color: AppColor.blueColor),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: Get.textTheme.labelMedium!.copyWith(
                  color: isSelected ? Colors.white : AppColor.darkColor2,
                ),
              ),
              if (isSelected) ...[
                5.horizontalSpaceRadius,
                Icon(
                  Icons.check,
                  size: 18.r,
                  color: Colors.white,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
