import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/message/chat_controller.dart';
import 'package:flutter_chat_app/models/api_response_model.dart';
import 'package:flutter_chat_app/models/chat_list_model.dart';
import 'package:flutter_chat_app/view/common_widgets/custom_loader.dart';
import 'package:flutter_chat_app/view/common_widgets/error_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_routes.dart';
import 'widget/chat_list_item.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  ChatController controller = Get.put(ChatController());

  @override
  void initState() {
    controller.listenChats();
    Future.delayed(
      Duration.zero,
      () => controller.getChatsRepo(),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ChatController>(builder: (controller) {
      return Scaffold(
        body: switch (controller.status) {
          Status.loading => const CustomLoader(),
          Status.error => ErrorScreen(
              onTap: () => controller.getChatsRepo(),
            ),
          Status.completed => Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: ListView.builder(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                itemCount: controller.chats.length,
                itemBuilder: (context, index) {
                  ChatListModel item = controller.chats[index];
                  return GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.message,
                        parameters: {"chat": jsonEncode(item.toJson())}),
                    child: ChatListItem(
                      image: item.image,
                      name: item.name,
                      message: item.message,
                    ),
                  );
                },
              ),
            ),
        },
      );
    });
  }
}
