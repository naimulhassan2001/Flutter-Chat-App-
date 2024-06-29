

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/controller/home/home_controller.dart';
import 'package:flutter_chat_app/view/common_widgets/text/custom_text.dart';
import 'package:flutter_chat_app/view/screen/home/widget/home_item.dart';
import 'package:flutter_chat_app/view/screen/message/chat_list_screen.dart';
import 'package:flutter_chat_app/view/screen/profile/profile_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_colors.dart';
import '../message/widget/chat_list_item.dart';

class Home extends StatelessWidget {
  Home({super.key});

  List pages = [const ChatListScreen(), const MyProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: CustomText(
              text: "App Name".tr,
              fontSize: 28.sp,
              left: 20.w,
              fontWeight: FontWeight.w600,
            ),
            backgroundColor: AppColors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(20.r),
              ),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  controller.getAllUserRepo();
                  showSearch(context: context, delegate: MySearchDelegate());
                },
                icon: const Icon(
                  Icons.search,
                  color: AppColors.black,
                ),
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
          body: pages[controller.index],
          bottomNavigationBar: CurvedNavigationBar(
              index: controller.index,
              onTap: controller.changeIndex,
              color: AppColors.green,
              height: 60.h,
              buttonBackgroundColor: Colors.green,
              backgroundColor: Colors.white,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 500),
              items: [
                HomeItem(
                    iconData: Icons.home,
                    isPadding: controller.index != 0 ? true : false),
                HomeItem(
                    iconData: Icons.person,
                    isPadding: controller.index != 1 ? true : false),
              ]),
        );
      },
    );
  }
}

class MySearchDelegate extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () => close(context, null), icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          if (query.isEmpty) {
            close(context, null);
          } else {
            query = "";
          }
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: CustomText(
        text: query,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    HomeController.instance.getSuggestions(query);
    return GetBuilder<HomeController>(
      builder: (controller) => ListView.builder(
        itemCount: controller.suggestions.length,
        itemBuilder: (context, index) {
          final user = controller.suggestions[index];
          return GestureDetector(
            onTap: () => controller.createChatRoom(user),
            child: ChatListItem(
              image: user.image,
              name: user.name,
              message: user.email,
            ),
          );
        },
      ),
    );
  }
}
