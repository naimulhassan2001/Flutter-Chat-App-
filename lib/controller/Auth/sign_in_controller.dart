import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/app_routes.dart';
import '../../helpers/prefs_helper.dart';
import '../../services/api_service.dart';
import '../../utils/app_url.dart';
import '../../utils/app_utils.dart';

class SignInController extends GetxController {
  bool isLoading = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUpRepo() async {
    isLoading = true;
    update();

    var body = {
      "email": emailController.text,
      "password": passwordController.text
    };

    var response = await ApiService.postApi(
      AppUrls.signIn,
      body,
    );

    if (response.statusCode == 200) {
      print(response.body);
      print(response.body.runtimeType);
      var data = jsonDecode(response.body);
      PrefsHelper.token = data["data"]["accessToken"];
      PrefsHelper.myName = data["data"]['name'];
      PrefsHelper.myEmail = data["data"]['email'];
      PrefsHelper.myImage = data["data"]['image'];
      PrefsHelper.isLogIn = true;

      PrefsHelper.setString("token", PrefsHelper.token);
      PrefsHelper.setString("myName", PrefsHelper.myName);
      PrefsHelper.setString("myEmail", PrefsHelper.myEmail);
      PrefsHelper.setString("myImage", PrefsHelper.myImage);
      PrefsHelper.setBool("isLogIn", PrefsHelper.isLogIn);
      Get.offAllNamed(AppRoutes.chatList);
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }

    isLoading = false;
    update();
  }
}
