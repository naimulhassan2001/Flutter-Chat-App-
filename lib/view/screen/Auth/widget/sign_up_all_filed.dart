import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helpers/other_helper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../../utils/app_colors.dart';
import '../../../../controller/Auth/sign_up_controller.dart';
import '../../../common_widgets/pop up/custom_pop_up_menu_button.dart';
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
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              controller: controller.emailController,
              prefixIcon: const Icon(Icons.mail),
              labelText: "Email".tr,
              validator: OtherHelper.emailValidator,
            ),
            SizedBox(
              height: 20.h,
            ),
            IntlPhoneField(
              controller: controller.numberController,
              initialValue: "",
              decoration: InputDecoration(
                hintText: "Phone Number".tr,
                fillColor: AppColors.greyscale,
                filled: true,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 14.h),
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
              ),
              initialCountryCode: "BD",
              disableLengthCheck: false,
              autovalidateMode: AutovalidateMode.disabled,
            ),
            CustomTextField(
              controller: controller.genderController,
              suffixIcon: PopUpMenu(
                onTap: controller.onSelectItem,
                items: controller.list,
                selectedItem: controller.genderController.text,
              ),
              labelText: "Gender".tr,
              validator: OtherHelper.validator,
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomTextField(
              controller: controller.passwordController,
              prefixIcon: const Icon(Icons.lock),
              isPassword: true,
              labelText: "Password".tr,
              validator: OtherHelper.passwordValidator,
            ),
            SizedBox(
              height: 20.h,
            ),
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
