import 'package:flutter/material.dart';
import 'package:flutter_chat_app/extension/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../controller/Auth/forgot_password_controller.dart';
import '../../../../helpers/other_helper.dart';
import '../../../common_widgets/button/custom_button.dart';
import '../../../common_widgets/text/custom_text.dart';
import '../../../common_widgets/text_field/custom_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "Forgot Password".tr,
            fontWeight: FontWeight.w700,
            fontSize: 24.sp,
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                105.height,
                CustomTextField(
                  controller: controller.emailController,
                  prefixIcon: const Icon(Icons.mail),
                  labelText: "Email".tr,
                  validator: OtherHelper.emailValidator,
                ),
                100.height,
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.h, horizontal: 20.w),
          child: CustomButton(
            titleText: "Continue".tr,
            isLoading: controller.isLoadingEmail,
            onTap: () {
              if (formKey.currentState!.validate()) {
                controller.forgotPasswordRepo();
              }
            },
          ),
        ),
      ),
    );
  }
}
