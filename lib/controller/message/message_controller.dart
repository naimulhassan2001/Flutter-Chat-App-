import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/helpers/prefs_helper.dart';
import 'package:flutter_chat_app/models/api_response_model.dart';
import 'package:flutter_chat_app/models/message_model.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
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

  addNewMessage(String chatId) async {
    TimeOfDay currentTime = TimeOfDay.now();

    messages.insert(
        0,
        ChatMessageModel(
            time: currentTime.format(Get.context!).toString(),
            message: messageController.text,
            image: AppImages.profile,
            isMe: true));
    update();

    var body = {
      "chat": chatId,
      "message": messageController.text,
      "sender": PrefsHelper.userId
    };

    messageController.clear();

    SocketServices.socket.emitWithAck("send-message", body, ack: (data) {
      if (kDebugMode) {
        print(
            "===============================================================> Received acknowledgment: $data");
      }
    });
  }

  getMessagesRepo(String chatId) async {
    status = Status.loading;
    update();

    var response = await ApiService.getApi("${AppUrls.conversation}/$chatId");

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"] ?? [];

      for (var item in data) {
        MessageModel message = MessageModel.fromJson(item);

        messages.add(ChatMessageModel(
            time: message.createdAt,
            message: message.message,
            image: message.image,
            isMe: message.senderId == PrefsHelper.userId ? true : false));
      }

      status = Status.completed;
      update();
    } else {
      status = Status.completed;
      update();

      Utils.snackBarMessage(response.statusCode.toString(), response.message);
    }
  }

  listenMessage(String chatId) async {
    SocketServices.socket.on("receive-message::${PrefsHelper.userId}", (data) {
      if (kDebugMode) {
        print("socket data get : $data");
      }
      MessageModel message = MessageModel.fromJson(data);
      var time = localTime(message.createdAt);

      messages.insert(
          0,
          ChatMessageModel(
              isNotice: message.messageType == "notice" ? true : false,
              time: time,
              message: message.message,
              image: message.image,
              isMe: message.senderId == PrefsHelper.userId ? true : false));
      update();
    });
  }

  String localTime(String createdAt) {
    DateTime localTime = DateTime.tryParse(createdAt) ?? DateTime.now();
    var time = localTime.toLocal().toString().split(" ")[1];
    var hour = time.split(":")[0];
    var minute = time.split(":")[1].split(":")[0];

    return "$hour:$minute";
  }
}




class TherapistController extends GetxController{

  TextEditingController searchPatentName = TextEditingController();

  TextEditingController messageController = TextEditingController();

  RxInt index = 0.obs;
  RxString sendMessage = ''.obs;
  File? selectedMessageImage;
  RxBool isCallConnected = true.obs;
  RxBool isVideoCall = false.obs;
  RxBool isVolumeMute = false.obs;
  RxBool isMicMute = false.obs;
  Rx<Offset> position = Offset(80.0, 20.0).obs;
  RxDouble dragHorizontal = 20.0.obs;
  RxDouble dragVertical = 80.0.obs;

  Map sessionListMap =
  {
    "totalSessions" : 26,
    "completeSessions" : 03
  };


  Future openGallery() async {
    final pickImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    selectedMessageImage = File(pickImage!.path);
    update();
  }

// Future<void> openCamera() async{
//   final cameras = await availableCameras();
//   Get.to(VideoCallScreen(cameras: cameras));
// }

}
