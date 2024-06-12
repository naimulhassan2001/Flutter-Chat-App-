import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../controller/Auth/forgot_password_controller.dart';
import '../../../common_widgets/button/custom_button.dart';
import '../../../common_widgets/text/custom_text.dart';

class VerifyForgotPassword extends StatefulWidget {
  const VerifyForgotPassword({super.key});

  @override
  State<VerifyForgotPassword> createState() => _VerifyForgotPasswordState();
}

class _VerifyForgotPasswordState extends State<VerifyForgotPassword> {
  final formKey = GlobalKey<FormState>();

  ForgetPasswordController controller = Get.put(ForgetPasswordController());

  @override
  void initState() {
    controller.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Forgot Password".tr,
          fontWeight: FontWeight.w700,
          fontSize: 24.sp,
        ),
      ),
      body: GetBuilder<ForgetPasswordController>(
        builder: (controller) => SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Center(
                  child: CustomText(
                    text:
                    "${"Code has been send to".tr} ${controller.emailController.text}",
                    fontSize: 18.sp,
                    top: 100.h,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    bottom: 60.h,
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: PinCodeTextField(
                    controller: controller.otpController,
                    validator: (value) {
                      if (value != null && value.length == 6) {
                        return null;
                      } else {
                        return "Otp is inValid".tr;
                      }
                    },
                    autoDisposeControllers: false,
                    cursorColor: AppColors.black,
                    appContext: (context),
                    autoFocus: true,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: 50.h,
                      fieldWidth: 50.w,
                      activeFillColor: AppColors.transparent,
                      selectedFillColor: AppColors.transparent,
                      inactiveFillColor: AppColors.transparent,
                      borderWidth: 0.5.w,
                      selectedColor: AppColors.white500,
                      activeColor: AppColors.white500,
                      inactiveColor: AppColors.white500,
                    ),
                    length: 6,
                    keyboardType: TextInputType.number,
                    autovalidateMode: AutovalidateMode.disabled,
                    enableActiveFill: true,
                  ),
                ),
                GestureDetector(
                  onTap: controller.time == '00:00'
                      ? () {
                    controller.startTimer();
                    controller.forgotPasswordRepo();
                  }
                      : () {},
                  child: CustomText(
                    text: controller.time == '00:00'
                        ? "Resend Code"
                        : "${"Resend code in".tr}  ${controller.time} minute",
                    top: 60.h,
                    bottom: 100.h,
                    fontSize: 18.sp,
                  ),
                ),
                CustomButton(
                  titleText: "Verify".tr,
                  isLoading: controller.isLoadingVerify,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      controller.verifyOtpRepo();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}