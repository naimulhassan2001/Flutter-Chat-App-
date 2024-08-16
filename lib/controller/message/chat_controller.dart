import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_chat_app/models/api_response_model.dart';
import 'package:flutter_chat_app/models/chat_list_model.dart';
import 'package:flutter_chat_app/services/api_service.dart';
import 'package:flutter_chat_app/utils/app_url.dart';
import 'package:flutter_chat_app/utils/app_utils.dart';
import 'package:get/get.dart';

import '../../helpers/prefs_helper.dart';
import '../../services/socket_service.dart';

class ChatController extends GetxController {
  List chats = [];

  Status status = Status.completed;

  getChatsRepo() async {
    status = Status.loading;
    update();

    var response = await ApiService.getApi(AppUrls.chat);

    if (response.statusCode == 200) {
      chats.clear();
      List data = jsonDecode(response.body)["data"] ?? [];

      for (var item in data) {
        chats.add(ChatListModel.fromJson(item));
      }

      status = Status.completed;
      update();
    } else {
      status = Status.completed;
      update();

      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }

  listenChats() async {
    SocketServices.socket.on("update-chatlist::${PrefsHelper.userId}", (data) {
      if (kDebugMode) {
        print("socket data get : $data");
      }

      chats.clear();

      for (var item in data["chatList"]) {
        chats.add(ChatListModel.fromJson(item));
      }

      update();
    });
  }
}
