import 'package:flutter/material.dart';
import 'package:flutter_chat_app/utils/app_images.dart';
import 'package:flutter_chat_app/utils/app_url.dart';
import 'package:flutter_chat_app/view/common_widgets/image/custom_image.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../utils/app_colors.dart';
import '../../../common_widgets/text/custom_text.dart';

class ChatBubbleMessage extends StatelessWidget {
  final String time;
  final String message;
  final String image;
  final bool isMe;
  final bool isNotice;
  final VoidCallback onTap;

  const ChatBubbleMessage({
    super.key,
    required this.time,
    required this.message,
    required this.image,
    required this.isMe,
    required this.onTap,
    this.isNotice = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // //=======-============================Question====================================

          isNotice
              ? Center(
                  child: CustomText(
                  text: message,
                  maxLines: 1,
                  top: 8.h,
                  bottom: 8.h,
                  fontWeight: FontWeight.w700,
                ))
              : isMe
                  ? ChatBubble(
                      alignment: Alignment.centerRight,
                      backGroundColor: AppColors.grey50,
                      margin: EdgeInsets.only(
                        left: Get.width * 0.20,
                      ),
                      clipper: ChatBubbleClipper9(
                        type: BubbleType.sendBubble,
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                        ),
                        child: CustomText(
                          maxLines: 100000,
                          textAlign: TextAlign.end,
                          fontWeight: FontWeight.w400,
                          text: message,
                        ),
                      ),
                    )
                  : Row(
                      children: [
                        CircleAvatar(
                            backgroundColor: AppColors.transparent,
                            radius: 25.sp,
                            child: ClipOval(
                                //     child: Image.asset(
                                //   image,
                                //   width: 40.sp,
                                //   height: 40.sp,
                                //   fit: BoxFit.fill,
                                // )
                                child: CustomImage(
                              imageSrc: "${AppUrls.imageUrl}$image",
                              height: 40.sp,
                              width: 40.sp,
                              defaultImage: AppImages.defaultProfile,
                              imageType: ImageType.network,
                            ))),
                        Expanded(
                          child: ChatBubble(
                            backGroundColor: AppColors.primaryColor,
                            shadowColor: AppColors.black,
                            clipper: ChatBubbleClipper10(
                              type: BubbleType.receiverBubble,
                            ),
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.only(
                              right: Get.width * 0.20,
                            ),
                            child: CustomText(
                              maxLines: 100000,
                              textAlign: TextAlign.start,
                              fontWeight: FontWeight.w400,
                              color: AppColors.white,
                              text: message,
                            ),
                          ),
                        ),
                      ],
                    )
        ],
      ),
    );
  }
}
