import 'dart:convert';

import 'package:flutter_chat_app/helpers/other_helper.dart';
import 'package:flutter_chat_app/models/api_response_model.dart';
import 'package:flutter_chat_app/models/user_model.dart';
import 'package:flutter_chat_app/services/api_service.dart';
import 'package:flutter_chat_app/utils/app_url.dart';
import 'package:flutter_chat_app/utils/app_utils.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  String? image;
  Status status = Status.completed;

  static UserModel userModel = UserModel();

  getProfileRepo() async {
    if (userModel.id.isNotEmpty) return;
    status = Status.loading;
    update();

    var response = await ApiService.getApi(AppUrls.profile);
    if (response.statusCode == 200) {
      userModel = UserModel.fromJson(jsonDecode(response.body)['data']);
      status = Status.completed;
      update();
    } else {
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
      status = Status.error;
      update();
    }
  }

  @override
  void onInit() {
    getProfileRepo();
    super.onInit();
  }

  getProfileImage() async {
    image = await OtherHelper.openGallery();
    update();
  }
}
