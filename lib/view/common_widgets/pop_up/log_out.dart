 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../helpers/prefs_helper.dart';
import '../../../utils/app_colors.dart';
import '../button/custom_button.dart';
import '../text/custom_text.dart';

logOutPopUp() {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        contentPadding: EdgeInsets.all(12.sp),
        title: Align(
          alignment: Alignment.center,
          child: CustomText(
            text: "Are You sure?\n You want to log out".tr,
            maxLines: 2,
            fontSize: 18,
            bottom: 20.h,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                  child: CustomButton(
                    titleText: "Yes".tr,
                    buttonHeight: 40.h,
                    onTap: () => PrefsHelper.removeAllPrefData(),
                  )),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                  child: CustomButton(
                    titleText: "No".tr,
                    borderWidth: 1.5,
                    buttonHeight: 40.h,
                    borderColor: AppColors.blue,
                    buttonColor: AppColors.transparent,
                    titleColor: AppColors.black,
                    onTap: () => Get.back(),
                  )),


            ],
          ),
        ],
      );
    },
  );
}