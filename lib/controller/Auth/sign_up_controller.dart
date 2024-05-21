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

  List list = ["Male", "Female", "Other"];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController genderController = TextEditingController(text: "Male");
  TextEditingController addressController = TextEditingController();

  onSelectItem(int index) {
    genderController.text = list[index];
    update();
    Get.back();
  }

  signUpRepo() async {
    isLoading = true;
    update();

    var body = {
      "name": nameController.text,
      "email": emailController.text,
      "number": numberController.text,
      "gender": genderController.text,
      "password": passwordController.text
    };

    var response = await ApiService.multipartRequest(
      url: AppUrls.signUp,
      body: body,
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
