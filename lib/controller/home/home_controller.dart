import 'dart:convert';

import 'package:flutter_chat_app/core/app_routes.dart';
import 'package:flutter_chat_app/helpers/prefs_helper.dart';
import 'package:flutter_chat_app/models/chat_list_model.dart';
import 'package:flutter_chat_app/models/user_model.dart';
import 'package:get/get.dart';

import '../../services/api_service.dart';
import '../../services/socket_service.dart';
import '../../utils/app_url.dart';
import '../../utils/app_utils.dart';

class HomeController extends GetxController {
  int index = 0;

  List<UserModel> users = [];

  List<UserModel> suggestions = [];

  static HomeController get instance => Get.put(HomeController());

  changeIndex(index) {
    this.index = index;
    update();
  }

  getSuggestions(String query) {
    suggestions = users.where(
      (user) {
        final result = user.name.toLowerCase();
        final input = query.toLowerCase();
        return result.contains(input);
      },
    ).toList();
  }

  Future getAllUserRepo() async {
    var response = await ApiService.getApi(AppUrls.users);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"] ?? [];

      for (var item in data) {
        users.add(UserModel.fromJson(item));
      }
      suggestions.clear();
      update();
    } else {
      update();
      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }

  createChatRoom(UserModel user) async {
    var body = {
      "participants": [PrefsHelper.userId, user.id],
      "name": "",
      "creator": PrefsHelper.userId
    };

    print("================================================> body $body");

    SocketServices.socket.emitWithAck("request-chat", body, ack: (data) {
      print(
          "===============================================================> Received acknowledgment: $data");

      ChatListModel item = ChatListModel.fromJson(data['data']);

      Get.toNamed(AppRoutes.message,
          parameters: {"chat": jsonEncode(item.toJson())});
    });
  }
}
