import 'package:coffee_app/configs/theme/colors.dart';
import 'package:coffee_app/modules/features/menu/controllers/detail_menu_controller.dart';
import 'package:coffee_app/modules/features/menu/view/components/holder_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class NoteBottomSheet extends StatelessWidget {
  final TextEditingController noteController = TextEditingController(text: DetailMenuController.to.note.value);

  NoteBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 17.r, vertical: 19.r),
      child: Wrap(
        children: [
          const HolderBottomSheet(),
          13.verticalSpacingRadius,
          Text('Create note'.tr, style: Get.textTheme.headlineSmall),
          13.verticalSpacingRadius,
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: noteController,
                  style: Get.textTheme.bodySmall,
                  decoration: InputDecoration(
                    hintText: 'Add note'.tr,
                    hintStyle: Get.textTheme.bodySmall,
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.blueColor, width: 2),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColor.blueColor, width: 2),
                    ),
                  ),
                  maxLength: 100,
                  autofocus: true,
                ),
              ),
              12.verticalSpacingRadius,
              IconButton(
                icon: const Icon(Icons.check_circle),
                splashRadius: 20.r,
                color: AppColor.blueColor,
                onPressed: () {
                  DetailMenuController.to.setNote(noteController.text);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
