import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../controller/message/message_controller.dart';
import '../../../utils/app_images.dart';

class VideoCallScreen extends StatelessWidget {
  VideoCallScreen({super.key});

  TherapistController therapistController = Get.put(TherapistController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            Image.asset(
              AppImages.callerImg,
              fit: BoxFit.fill,
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
            ),
            Positioned(
              top: 48.h,
              left: 20.w,
              child: IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: Icon(
                  Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                  color: Colors.green,
                ),
              ),
            ),

            ///<<<===================Caller Image==============================>
            ///
            Positioned(
              top: therapistController.dragVertical.value,
              right: therapistController.dragHorizontal.value,
              child: GestureDetector(
                onPanUpdate: (details) async {
                  therapistController.dragHorizontal.value = max(
                      0,
                      therapistController.dragHorizontal.value -
                          details.delta.dx);
                  therapistController.dragVertical.value = max(
                      therapistController.dragVertical.value + details.delta.dy,
                      0);
                },
                child: Container(
                  height: 98.h,
                  width: 86.w,
                  decoration: ShapeDecoration(
                    image: const DecorationImage(
                        image: AssetImage(AppImages.patient_1)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: const BorderSide(color: AppColors.white),
                    ),
                  ),
                ),
              ),
            ),

            ///<<<===================Call control bar====================>
            Positioned(
              right: 20.w,
              left: 20.w,
              bottom: 40.h,
              child: Container(
                height: 60.h,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: AppColors.grey700,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 36,
                      width: 36,
                      decoration: const ShapeDecoration(
                        color: AppColors.black,
                        shape: CircleBorder(),
                      ),
                      child: InkWell(
                          onTap: () {
                            therapistController.isVideoCall.value =
                                !therapistController.isVideoCall.value;
                          },
                          child: Icon(
                            therapistController.isVideoCall.value
                                ? Icons.videocam_outlined
                                : Icons.videocam_off_outlined,
                            color: AppColors.white,
                          )),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      decoration: const ShapeDecoration(
                        color: AppColors.black,
                        shape: CircleBorder(),
                      ),
                      child: InkWell(
                          onTap: () {
                            therapistController.isVolumeMute.value =
                                !therapistController.isVolumeMute.value;
                          },
                          child: Icon(
                            therapistController.isVolumeMute.value
                                ? Icons.volume_up_outlined
                                : Icons.volume_off_outlined,
                            color: AppColors.white,
                          )),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      decoration: const ShapeDecoration(
                        color: AppColors.black,
                        shape: CircleBorder(),
                      ),
                      child: InkWell(
                          onTap: () {
                            therapistController.isMicMute.value =
                                !therapistController.isMicMute.value;
                          },
                          child: Icon(
                            therapistController.isMicMute.value
                                ? Icons.mic_none_outlined
                                : Icons.mic_off_outlined,
                            color: AppColors.white,
                          )),
                    ),
                    Container(
                      height: 36,
                      width: 36,
                      decoration: const ShapeDecoration(
                        color: AppColors.red,
                        shape: CircleBorder(),
                      ),
                      child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.call_end,
                            color: AppColors.white,
                          )),
                    )
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }
}
