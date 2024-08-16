import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/core/app_routes.dart';
import 'package:flutter_chat_app/helpers/prefs_helper.dart';
import 'package:flutter_chat_app/services/api_service.dart';
import 'package:flutter_chat_app/utils/app_url.dart';
import 'package:flutter_chat_app/utils/app_utils.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool isPopUpOpen = false;
  bool isLoading = false;
  bool isLoadingVerify = false;

  List list = ["Male", "Female", "Other"];

  Timer? _timer;
  int start = 0;

  String time = "";

  static SignUpController get instance => Get.put(SignUpController());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  signUpRepo() async {
    isLoading = true;
    update();

    var body = {
      "name": nameController.text,
      "email": emailController.text,
      "password": passwordController.text
    };

    var response = await ApiService.multipartRequest(
      url: AppUrls.signUp,
      body: body,
    );

    if (response.statusCode == 200) {
      Get.toNamed(AppRoutes.userVerify);
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }

  void startTimer() {
    _timer?.cancel(); // Cancel any existing timer
    start = 180; // Reset the start value
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (start > 0) {
        start--;
        final minutes = (start ~/ 60).toString().padLeft(2, '0');
        final seconds = (start % 60).toString().padLeft(2, '0');

        time = "$minutes:$seconds";

        update();
      } else {
        _timer?.cancel();
      }
    });
  }

  Future<void> verifyOtpRepo() async {
    isLoadingVerify = true;
    update();
    Map<String, String> body = {
      "email": emailController.text,
      "otp": otpController.text
    };
    var response = await ApiService.postApi(AppUrls.userVerify, body);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      PrefsHelper.token = data["data"]["token"]["accessToken"];
      PrefsHelper.myName = data["data"]["user"]['name'];
      PrefsHelper.myEmail = data["data"]["user"]['email'];
      PrefsHelper.myImage = data["data"]["user"]['image'];
      PrefsHelper.userId = data["data"]["user"]['_id'];
      PrefsHelper.isLogIn = true;

      PrefsHelper.setString("token", PrefsHelper.token);
      PrefsHelper.setString("myName", PrefsHelper.myName);
      PrefsHelper.setString("myEmail", PrefsHelper.myEmail);
      PrefsHelper.setString("myImage", PrefsHelper.myImage);
      PrefsHelper.setString("userId", PrefsHelper.userId);
      PrefsHelper.setBool("isLogIn", PrefsHelper.isLogIn);
      Get.offAllNamed(AppRoutes.home);
    } else {
      Get.snackbar(response.statusCode.toString(), response.message);
    }

    isLoadingVerify = false;
    update();
  }
}
