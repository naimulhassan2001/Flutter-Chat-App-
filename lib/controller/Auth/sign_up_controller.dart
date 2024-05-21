import 'package:flutter/cupertino.dart';
import 'package:flutter_chat_app/services/api_service.dart';
import 'package:flutter_chat_app/utils/app_url.dart';
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

    var response = await ApiService.postApi(
      AppUrls.signUp,
      body,
    );

    isLoading = false;
    update();
    print("body ${response.statusCode}");
  }
}
