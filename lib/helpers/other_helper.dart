import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/app_colors.dart';

class OtherHelper {
  static RegExp emailRegexp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp passRegExp = RegExp(r'(?=.*[a-z])(?=.*[0-9])');

  static String? validator(value) {
    print(value);
    if (value.isEmpty) {
      return "This field is required";
    } else {
      return null;
    }
  }

  static String? emailValidator(value) {
    if (value.isEmpty) {
      return "This field is required".tr;
    } else if (!emailRegexp.hasMatch(value)) {
      return "Enter valid email".tr;
    } else {
      return null;
    }
  }


  static String? passwordValidator(value) {
    if (value.isEmpty) {
      return "This field is required";
    } else if (value.length < 8) {
      return "password validation".tr;
    } else if (!passRegExp.hasMatch(value)) {
      return "password validation".tr;
    } else {
      return null;
    }
  }

  static String? confirmPasswordValidator(value, passwordController) {
    if (value.isEmpty) {
      return "This field is required".tr;
    } else if (value != passwordController.text) {
      return "The password does not match".tr;
    } else {
      return null;
    }
  }


  static Future<void> dateOfBirthPicker(
      TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      builder: (context, child) =>
          Theme(
              data: Theme.of(context).copyWith(
                colorScheme: const ColorScheme.light(
                  primary: AppColors.primaryColor, // <-- SEE HERE
                  onPrimary: AppColors.white, // <-- SEE HERE
                  onSurface: AppColors.black, // <-- SEE HERE
                ),
              ),
              child: child!),
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      controller.text = "${picked.year}/${picked.month}/${picked.day}";
    }
  }


  static Future<String?> openGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (getImages == null) return null;

    if (kDebugMode) {
      print(getImages.path);
    }

    return getImages.path;
  }

  //Pick Image from Camera

  static Future<String?> openCamera() async {
    final ImagePicker picker = ImagePicker();
    final XFile? getImages =
    await picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (getImages == null) return null;

    if (kDebugMode) {
      print(getImages.path);
    }

    return getImages.path;
  }


}
