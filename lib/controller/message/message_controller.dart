import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helpers/prefs_helper.dart';
import 'package:flutter_chat_app/models/api_response_model.dart';
import 'package:flutter_chat_app/models/message_model.dart';
import 'package:get/get.dart';
import '../../models/chat_message_model.dart';
import '../../services/api_service.dart';
import '../../services/socket_service.dart';
import '../../utils/app_images.dart';
import '../../utils/app_url.dart';
import '../../utils/app_utils.dart';

class MessageController extends GetxController {
  Status status = Status.completed;
  bool isLoading = false;
  bool isMoreLoading = false;

  List messages = [];

  ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  addNewMessage() async {
    TimeOfDay currentTime = TimeOfDay.now();

    messages.insert(
        0,
        ChatMessageModel(
            time: currentTime.format(Get.context!).toString(),
            message: messageController.text,
            image: AppImages.profile,
            isMe: true));
    update();

    messageController.clear();
  }

  getMessagesRepo(String chatId) async {
    status = Status.loading;
    update();

    var response = await ApiService.getApi("${AppUrls.conversation}/$chatId");

    print(response.statusCode);

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"] ?? [];

      for (var item in data) {
        MessageModel message = MessageModel.fromJson(item);

        messages.add(ChatMessageModel(
            time: message.createdAt,
            message: message.message,
            image: message.image,
            isMe: message.sender == PrefsHelper.userId ? true : false));
      }

      print(messages.length);

      status = Status.completed;
      update();
    } else {
      status = Status.completed;
      update();

      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }

  listenMessage(String chatId) async {
    SocketServices.socket.on('receive-message::$chatId', (data) {
      print("socket data get : $data");
      MessageModel message = MessageModel.fromJson(data);
      var time = localTime(message.createdAt);

      messages.insert(
          0,
          ChatMessageModel(
              isNotice: message.messageType == "notice" ? true : false,
              time: time,
              message: message.message,
              image: message.image,
              isMe: message.sender == PrefsHelper.userId ? true : false));
      update();

      print(
          "============================================>messages ${messages.length}");
      print("============================================>data $data");
    });
  }

  String localTime(String createdAt) {
    DateTime localTime = DateTime.parse(createdAt).toLocal();
    var time = localTime.toString().split(" ")[1];
    var hour = time.split(":")[0];
    var minute = time.split(":")[1].split(":")[0];

    return "$hour:$minute";
  }
}
