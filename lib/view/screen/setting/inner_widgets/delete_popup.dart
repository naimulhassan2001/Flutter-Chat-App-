import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import '../../../common_widgets/button/custom_button.dart';
import '../../../common_widgets/text/custom_text.dart';

deletePopUp() {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        contentPadding: const EdgeInsets.only(bottom: 12),
        title: Form(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CustomText(
                  text: "Are you sure".tr,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.black,
                  maxLines: 1,
                  bottom: 18.h,
                ),
              ),
              CustomText(
                text:
                    "All your changes will be deleted and you will no longer be able to access them"
                        .tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.black,
                maxLines: 4,
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: CustomButton(
                  titleText: "Cancel".tr,
                  titleColor: AppColors.black,
                  borderColor: AppColors.black,
                  buttonColor: AppColors.transparent,
                  buttonRadius: 4.r,
                  buttonHeight: 40.h,
                  onTap: () => Get.back(),
                ),
              ),
              SizedBox(
                width: 16.w,
              ),
              Expanded(
                child: CustomButton(
                  titleText: "Done".tr,
                  titleColor: AppColors.white,
                  borderColor: AppColors.black,
                  buttonColor: AppColors.black,
                  buttonRadius: 4.r,
                  buttonHeight: 40.h,
                  onTap: () => Get.back(),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
