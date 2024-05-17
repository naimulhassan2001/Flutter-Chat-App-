import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/chat_message_model.dart';
import '../../utils/app_images.dart';

class MessageController extends GetxController {
  bool isLoading = false;
  bool isMoreLoading = false;

  List messages = [
    ChatMessageModel(
        image: AppImages.profile, message: "hello", isMe: false, time: "9:30"),
    ChatMessageModel(
        image: AppImages.profile, message: "hello", isMe: true, time: "9:30"),
    ChatMessageModel(
        image: AppImages.profile, message: "hello", isMe: false, time: "9:30")
  ];

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
}
