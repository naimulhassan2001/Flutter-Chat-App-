import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool isPopUpOpen = false;

  List list = ["Male", "Female", "Other"];

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController genderController = TextEditingController(text: "Male");
  TextEditingController addressController = TextEditingController();


  onSelectItem(int index) {
    genderController.text = list[index];
    update();
    Get.back();
  }
}