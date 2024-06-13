import 'package:flutter/material.dart';
import 'package:flutter_chat_app/extension/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../core/app_routes.dart';
import '../../../../../helpers/other_helper.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../controller/Auth/change_password_controller.dart';
import '../../../common_widgets/button/custom_button.dart';
import '../../../common_widgets/text/custom_text.dart';
import '../../../common_widgets/text_field/custom_text_field.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: CustomText(
          text: "Change Password".tr,
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<ChangePasswordController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  50.height,
                  CustomTextField(
                    controller: controller.currentPasswordController,
                    hindText: "Current  Password".tr,
                    validator: OtherHelper.passwordValidator,
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  16.height,
                  CustomTextField(
                    controller: controller.newPasswordController,
                    hindText: "New Password".tr,
                    validator: OtherHelper.passwordValidator,
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  16.height,
                  CustomTextField(
                    controller: controller.confirmPasswordController,
                    hindText: "Confirm Password".tr,
                    validator: (value) => OtherHelper.confirmPasswordValidator(
                        value, controller.newPasswordController),
                    isPassword: true,
                    prefixIcon: Icon(
                      Icons.lock,
                      size: 20.sp,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: CustomText(
                      text: "Forgot Password".tr,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                      top: 16.h,
                      bottom: 40.h,
                    ),
                  ).end,
                  CustomButton(
                    titleText: "Confirm".tr,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.changePasswordRepo();
                      }
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
