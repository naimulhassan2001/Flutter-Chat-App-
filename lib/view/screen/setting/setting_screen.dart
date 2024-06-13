import 'package:flutter/material.dart';
import 'package:flutter_chat_app/view/common_widgets/item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes.dart';
import '../../../../utils/app_colors.dart';
import '../../../controller/setting/setting_controller.dart';
import '../../common_widgets/text/custom_text.dart';
import 'inner_widgets/delete_popup.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "Settings".tr,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<SettingController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                Item(
                  title: "Change Password".tr,
                  icon: Icons.lock_outline,
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                ),
                Item(
                  title: "Privacy Policy".tr,
                  icon: Icons.privacy_tip_outlined,
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                ),
                Item(
                  title: "About Us".tr,
                  icon: Icons.info_outline,
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                ),
                Item(
                  title: "Support".tr,
                  icon: Icons.support_agent_outlined,
                  onTap: () => Get.toNamed(AppRoutes.changePassword),
                ),
                Item(
                  title: "Delete account".tr,
                  icon: Icons.delete_forever,
                  iconColor: AppColors.red,
                  onTap: () => deletePopUp(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
