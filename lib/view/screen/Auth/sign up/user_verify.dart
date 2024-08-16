import 'package:flutter/material.dart';
import 'package:flutter_chat_app/view/common_widgets/button/custom_button.dart';
import 'package:flutter_chat_app/view/common_widgets/text/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../utils/app_string.dart';
import '../../../../controller/Auth/sign_up_controller.dart';


class VerifyUser extends StatefulWidget {
  const VerifyUser({super.key});

  @override
  State<VerifyUser> createState() => _VerifyUserState();
}

class _VerifyUserState extends State<VerifyUser> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    SignUpController.instance.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(
          text: AppString.otpVerify,
          fontWeight: FontWeight.w700,
          fontSize: 24,
        ),
      ),
      body: GetBuilder<SignUpController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 20.w),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Center(
                    child: CustomText(
                      text:
                      "${AppString.codeHasBeenSendTo} ${controller.emailController.text}",
                      fontSize: 18,
                      top: 100,
                      bottom: 60,
                      maxLines: 3,
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: PinCodeTextField(
                      controller: controller.otpController,
                      autoDisposeControllers: false,
                      cursorColor: AppColors.black,
                      appContext: (context),
                      autoFocus: true,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        fieldHeight: 60.h,
                        fieldWidth: 48.w,
                        borderRadius: BorderRadius.circular(8.r),
                        activeFillColor: AppColors.transparent,
                        selectedFillColor: AppColors.transparent,
                        inactiveFillColor: AppColors.transparent,
                        borderWidth: 0.5.w,
                        selectedColor: AppColors.primaryColor,
                        activeColor: AppColors.primaryColor,
                        inactiveColor: AppColors.black,
                      ),
                      length: 6,
                      keyboardType: TextInputType.number,
                      autovalidateMode: AutovalidateMode.disabled,
                      enableActiveFill: true,
                      validator: (value) {
                        if (value != null && value.length == 6) {
                          return null;
                        } else {
                          return AppString.otpIsInValid;
                        }
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: controller.time == '00:00'
                        ? () {
                      controller.startTimer();
                      // controller.signUpUser();
                    }
                        : () {},
                    child: CustomText(
                      text: controller.time == '00:00'
                          ? AppString.resendCode
                          : "${AppString.resendCodeIn} ${controller.time} ${AppString.minute}",
                      top: 60,
                      bottom: 100,
                      fontSize: 18,
                    ),
                  ),
                  CustomButton(
                      titleText: AppString.verify,
                      isLoading: controller.isLoadingVerify,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          controller.verifyOtpRepo();
                        }
                      })
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}