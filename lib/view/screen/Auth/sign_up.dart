import 'package:flutter/material.dart';
import 'package:flutter_chat_app/utils/app_images.dart';
import 'package:flutter_chat_app/view/screen/Auth/widget/already_account.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../controller/Auth/sign_up_controller.dart';
import '../../../core/app_routes.dart';
import '../../../utils/app_icons.dart';
import '../../common_widgets/button/custom_button.dart';
import '../../common_widgets/image/custom_image.dart';
import '../../common_widgets/text/custom_text.dart';
import 'widget/sign_up_all_filed.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: GetBuilder<SignUpController>(
          builder: (controller) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Form(
                key: formKey,
                child: Column(children: [
                  CustomText(
                    text: "Create Your Account".tr,
                    fontSize: 32.sp,
                    bottom: 20.h,
                  ),
                  const SignUpAllField(),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    titleText: "Sign up".tr,
                    isLoading: controller.isLoading,
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        controller.signUpRepo();
                      }
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  const AlreadyAccountRichText()
                ]),
              ),
            );
          },
        ));
  }
}
