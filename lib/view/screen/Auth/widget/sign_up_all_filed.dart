import 'package:flutter/material.dart';
import 'package:flutter_chat_app/extension/extension.dart';
import 'package:flutter_chat_app/helpers/other_helper.dart';
import 'package:get/get.dart';
import '../../../../controller/Auth/sign_up_controller.dart';
import '../../../common_widgets/text_field/custom_text_field.dart';

class SignUpAllField extends StatefulWidget {
  const SignUpAllField({super.key});

  @override
  State<SignUpAllField> createState() => _SignUpAllFieldState();
}

class _SignUpAllFieldState extends State<SignUpAllField> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignUpController>(
      builder: (controller) {
        return Column(
          children: [
            CustomTextField(
              prefixIcon: const Icon(Icons.person),
              labelText: "Full Name".tr,
              controller: controller.nameController,
              validator: OtherHelper.validator,
            ),
            20.height,
            CustomTextField(
              controller: controller.emailController,
              prefixIcon: const Icon(Icons.mail),
              labelText: "Email".tr,
              validator: OtherHelper.emailValidator,
            ),

            20.height,
            CustomTextField(
              controller: controller.passwordController,
              prefixIcon: const Icon(Icons.lock),
              isPassword: true,
              labelText: "Password".tr,
              validator: OtherHelper.passwordValidator,
            ),
            20.height,
            CustomTextField(
              controller: controller.confirmPasswordController,
              prefixIcon: const Icon(Icons.lock),
              isPassword: true,
              labelText: "Confirm Password".tr,
              validator: (value) {
                return OtherHelper.confirmPasswordValidator(
                    value, controller.passwordController);
              },
            ),
          ],
        );
      },
    );
  }
}
