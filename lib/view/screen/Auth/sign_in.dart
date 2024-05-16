import 'package:flutter/material.dart';
import 'package:flutter_chat_app/view/common_widgets/text/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomText(
            text: "Welcome to the".tr,
            fontSize: 18.sp,
            fontWeight: FontWeight.w400,
          )
        ],
      ),
    );
  }
}
