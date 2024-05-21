import 'package:flutter/material.dart';
import 'package:flutter_chat_app/models/api_response_model.dart';
import 'package:flutter_chat_app/models/chat_message_model.dart';
import 'package:flutter_chat_app/view/common_widgets/custom_loader.dart';
import 'package:flutter_chat_app/view/common_widgets/error_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../controller/message/message_controller.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_images.dart';
import '../../common_widgets/image/custom_image.dart';
import '../../common_widgets/text/custom_text.dart';
import '../../common_widgets/text_field/custom_text_field.dart';
import 'widget/chat_buddle_message.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({super.key});

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  String chatId = Get.parameters["chatId"] ?? "";
  String name = Get.parameters["name"] ?? "";
  String type = Get.parameters["type"] ?? "";

  MessageController controller = Get.put(MessageController());

  @override
  void initState() {
    Future.delayed(
      Duration.zero,
      () {
        controller.getMessagesRepo(chatId);
        controller.listenMessage(chatId);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MessageController>(builder: (controller) {
      return switch (controller.status) {
        Status.loading => const CustomLoader(),
        Status.error => ErrorScreen(
            onTap: () => controller.getMessagesRepo(chatId),
          ),
        Status.completed => Scaffold(
            appBar: AppBar(
              toolbarHeight: 70.h,
              backgroundColor: AppColors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20.r),
                ),
              ),
              leading: Padding(
                padding: EdgeInsets.only(left: 20.w, right: 20.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 30.sp,
                      backgroundColor: Colors.transparent,
                      child: ClipOval(
                        child: CustomImage(
                          imageSrc: AppImages.profile,
                          imageType: ImageType.png,
                          height: 60.sp,
                          width: 60.sp,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Katryn Murphy",
                          fontWeight: FontWeight.w700,
                          fontSize: 18.sp,
                        ),
                        CustomText(
                          text: "Therapist",
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                        ),
                      ],
                    ),
                    const Spacer(),
                    const Icon(Icons.more_vert_outlined)
                  ],
                ),
              ),
              leadingWidth: Get.width,
            ),
            body: controller.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    reverse: true,
                    controller: controller.scrollController,
                    itemCount: controller.isMoreLoading
                        ? controller.messages.length + 1
                        : controller.messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < controller.messages.length) {
                        ChatMessageModel message = controller.messages[index];
                        return ChatBubbleMessage(
                          image: message.image,
                          isNotice: message.isNotice,
                          time: message.time,
                          message: message.message,
                          isMe: message.isMe,
                          onTap: () {},
                        );
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
            bottomNavigationBar: AnimatedPadding(
              padding: MediaQuery.of(context).viewInsets,
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 20.w,
                      ),
                      Container(
                        padding: EdgeInsets.all(6.sp),
                        margin: EdgeInsets.only(right: 10.w),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(color: AppColors.black)),
                        child: const Icon(Icons.add_circle_outlined),
                      ),
                      Expanded(
                        child: CustomTextField(
                          maxLines: 1,
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.start,
                          hindText: "",
                          onFieldSubmitted: (value) =>
                              controller.addNewMessage(),
                          suffixIcon: GestureDetector(
                              onTap: () => controller.addNewMessage(),
                              child: const Icon(Icons.send)),
                          textStyle: GoogleFonts.prompt(
                              fontSize: 14.h,
                              fontWeight: FontWeight.w400,
                              color: AppColors.black),
                          fieldBorderColor: Colors.white,
                          fieldBorderRadius: 8,
                          controller: controller.messageController,
                        ),
                      ),
                      SizedBox(
                        width: 20.w,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  )
                ],
              ),
            ))
      };
    });
  }
}
