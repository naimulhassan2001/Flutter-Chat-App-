import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/api_response_model.dart';
import 'package:flutter_chat_app/utils/app_url.dart';
import 'package:flutter_chat_app/view/common_widgets/custom_loader.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../core/app_routes.dart';
import '../../../controller/profile/profile_controller.dart';
import '../../common_widgets/image/custom_image.dart';
import '../../common_widgets/item.dart';
import '../../common_widgets/pop_up/log_out.dart';
import '../../common_widgets/text/custom_text.dart';

class MyProfileScreen extends StatelessWidget {
  const MyProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<ProfileController>(
        builder: (controller) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                controller.status != Status.completed
                    ? const CustomLoader()
                    : Column(
                        children: [
                          Center(
                            child: CircleAvatar(
                              radius: 50.sp,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: CustomImage(
                                  imageSrc:
                                      "${AppUrls.imageUrl}${ProfileController.userModel.image}",
                                  imageType: ImageType.network,
                                  height: 100.sp,
                                  width: 100.sp,
                                ),
                              ),
                            ),
                          ),
                          CustomText(
                            text: ProfileController.userModel.name,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w700,
                            top: 20.h,
                            bottom: 40.h,
                          ),
                        ],
                      ),
                Item(
                  icon: Icons.person,
                  title: "Update Profile".tr,
                  onTap: () => Get.toNamed(AppRoutes.updateProfile),
                ),
                Item(
                  icon: Icons.settings,
                  title: "Settings".tr,
                  // onTap: () => Get.toNamed(AppRoutes.setting),
                ),
                Item(
                  icon: Icons.logout,
                  title: "Log Out".tr,
                  onTap: () => logOutPopUp(),
                  disableDivider: true,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
