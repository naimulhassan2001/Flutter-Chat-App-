import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/Auth/sign_in_controller.dart';
import 'package:flutter_chat_app/extension/extension.dart';
import 'package:flutter_chat_app/helpers/other_helper.dart';
import 'package:flutter_chat_app/utils/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../core/app_routes.dart';
import '../../../utils/app_colors.dart';
import '../../common_widgets/button/custom_button.dart';
import '../../common_widgets/image/custom_image.dart';
import '../../common_widgets/text/custom_text.dart';
import '../../common_widgets/text_field/custom_text_field.dart';


class SignIn extends StatelessWidget {
  SignIn({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<SignInController>(builder: (controller) {
        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomImage(
                    imageSrc: AppImages.logo,
                    height: 70.h,
                    imageType: ImageType.png,
                  ),
                ),
                CustomText(
                  text: "Login to Your Account".tr,
                  fontSize: 24.sp,
                  bottom: 20.h,
                ),
                20.height,
                CustomTextField(
                  prefixIcon: const Icon(Icons.mail),
                  controller: controller.emailController,
                  labelText: "Email".tr,
                  validator: OtherHelper.emailValidator,
                ),
               20.height,
                CustomTextField(
                  controller: controller.passwordController,
                  validator: OtherHelper.passwordValidator,
                  prefixIcon: const Icon(Icons.lock),
                  isPassword: true,
                  labelText: "Password".tr,

                ),

                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPassword),
                    child: CustomText(
                      text: "Forgot password".tr,
                      top: 16.h,
                      color: AppColors.blue,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                60.height,
                CustomButton(
                  titleText: "Sign in".tr,
                  isLoading: controller.isLoading,
                  onTap: () {
                    if(formKey.currentState!.validate()) {
                      controller.signInRepo();
                    }
                  },
                ),

              ],
            ),
          ),
        );
      },),
    );
  }
}