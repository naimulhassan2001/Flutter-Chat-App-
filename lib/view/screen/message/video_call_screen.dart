/*import 'dart:io';
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
}*/

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wakelock/wakelock.dart';
import '../../../controller/message/message_controller.dart';
import '../../../utils/payment_key.dart';

class VideoCallScreen extends StatefulWidget {
  const VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallState();
}

class _VideoCallState extends State<VideoCallScreen> {
  final callCon = Get.put(CallController());

  @override
  void initState() {
    super.initState();
    requestPermissions();
    Wakelock.enable(); // Turn on wakelock feature till call is running
  }

  Future<void> requestPermissions() async {
    await [Permission.microphone, Permission.camera].request();
  }

  @override
  void dispose() {
    // _engine.leaveChannel();
    // _engine.destroy();
    Wakelock.disable(); // Turn off wakelock feature after call end
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Obx(() => Padding(
                padding: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    Center(
                      child: callCon.localUserJoined.value == true
                          ? callCon.videoPaused.value == true
                              ? Container(
                                  color: Theme.of(context).primaryColor,
                                  child: Center(
                                      child: Text(
                                    "Remote Video Paused",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: Colors.white70),
                                  )))
                              : AgoraVideoView(
                                  controller: VideoViewController.remote(
                                    rtcEngine: callCon.engine,
                                    canvas: VideoCanvas(
                                        uid: callCon.myremoteUid.value),
                                    connection:
                                        const RtcConnection(channelId: channel),
                                  ),
                                )
                          : const Center(
                              child: Text(
                                'No Remote',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SizedBox(
                        width: 100,
                        height: 150,
                        child: Center(
                            child: callCon.localUserJoined.value
                                ? AgoraVideoView(
                                    controller: VideoViewController(
                                      rtcEngine: callCon.engine,
                                      canvas: const VideoCanvas(uid: 0),
                                    ),
                                  )
                                : const CircularProgressIndicator()),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 10,
                      right: 10,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                callCon.onToggleMute();
                              },
                              child: Icon(
                                callCon.muted.value ? Icons.mic : Icons.mic_off,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                callCon.onCallEnd();
                              },
                              child: const Icon(
                                Icons.call,
                                size: 35,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                callCon.onVideoOff();
                              },
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                child: Padding(
                                  padding: EdgeInsets.all(5),
                                  child: Center(
                                    child: Icon(
                                      Icons.photo_camera_front,
                                      size: 25,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                callCon.onSwitchCamera();
                              },
                              child: const Icon(
                                Icons.switch_camera,
                                size: 35,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
