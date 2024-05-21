import 'dart:convert';

import 'package:flutter_chat_app/core/app_routes.dart';
import 'package:flutter_chat_app/models/api_response_model.dart';
import 'package:flutter_chat_app/models/chat_list_model.dart';
import 'package:flutter_chat_app/services/api_service.dart';
import 'package:flutter_chat_app/utils/app_url.dart';
import 'package:flutter_chat_app/utils/app_utils.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  List chats = [];

  Status status = Status.completed;

  getChatsRepo() async {
    status = Status.loading;
    update();

    var response = await ApiService.getApi(AppUrls.chat);


    print(response.statusCode);


    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"] ?? [];

      for (var item in data) {
        chats.add(ChatListModel.fromJson(item));
      }

      print(chats.length);

      status = Status.completed;
      update();
    } else {
      status = Status.completed;
      update();

      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }
}
