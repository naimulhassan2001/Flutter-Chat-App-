import 'package:flutter/material.dart';
import 'package:flutter_chat_app/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../core/app_routes.dart';
import '../../../utils/app_images.dart';
import '../../common_widgets/text/custom_text.dart';
import 'widget/chat_list_item.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: CustomText(
          text: "Chat".tr,
          fontWeight: FontWeight.w600,
          fontSize: 24.sp,
        ),
        actions: [
          const Icon(
            Icons.search,
            color: AppColors.black,
          ),
          Padding(
            padding: EdgeInsets.only(right: 20.w, left: 10.w),
            child: const Icon(
              Icons.notifications,
              color: AppColors.black,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20.w),
          itemCount: 10,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.message),
              child: ChatListItem(
                image: AppImages.profile,
                name: "Sumaiya Akter",
                message: "Hi, How are you?",
              ),
            );
          },
        ),
      ),
    );
  }
}
