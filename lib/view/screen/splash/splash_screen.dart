import 'package:flutter/material.dart';
import 'package:flutter_chat_app/core/app_routes.dart';
import 'package:flutter_chat_app/utils/app_images.dart';
import 'package:flutter_chat_app/view/common_widgets/image/custom_image.dart';
import 'package:flutter_chat_app/view/common_widgets/text/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 3),
      () => Get.toNamed(AppRoutes.onboarding),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120.sp,
            width: 120.sp,
            margin: EdgeInsets.only(bottom: 12.h),
            decoration: BoxDecoration(
                image: const DecorationImage(image: AssetImage(AppImages.logo)),
                borderRadius: BorderRadius.circular(16.r)),
          ),
          Center(
            child: CustomText(
              text: "App Name".tr,
              fontWeight: FontWeight.w600,
              fontSize: 24.sp,
            ),
          )
        ],
      ),
    );
  }
}
