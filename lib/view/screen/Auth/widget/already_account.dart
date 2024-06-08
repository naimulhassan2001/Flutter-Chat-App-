import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../utils/app_colors.dart';

class AlreadyAccountRichText extends StatelessWidget {
  const AlreadyAccountRichText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "Already have an account".tr,
                  style: TextStyle(
                    color: AppColors.grey300,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: "  ".tr,
                  style: TextStyle(
                    color: AppColors.grey300,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextSpan(
                  text: "Sign in".tr,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}