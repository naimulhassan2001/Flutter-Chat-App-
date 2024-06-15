import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_chat_app/extension/extension.dart';
import 'package:flutter_chat_app/view/common_widgets/text/custom_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../utils/app_colors.dart';
import '../../../controller/message/message_controller.dart';
import '../../../utils/app_images.dart';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

import '../../../utils/payment_key.dart';

class VideoCallScreen extends StatefulWidget {
  VideoCallScreen({super.key});

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  TherapistController therapistController = Get.put(TherapistController());

  MessageController messageController = Get.put(MessageController());

  @override
  void initState() {
    messageController.initilize();
    super.initState();
  }

  @override
  void dispose() {
    messageController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        return Stack(
          children: [
            Center(
                child: messageController.videoPaused.value == true
                    ? messageController.myremoteUid.value == 0
                        ? const SizedBox()
                        : AgoraVideoView(
                            controller: VideoViewController.remote(
                              rtcEngine: messageController.engine,
                              canvas: VideoCanvas(
                                  uid: messageController.myremoteUid.value),
                              connection:
                                  const RtcConnection(channelId: channel),
                            ),
                          )
                    : const CustomText(text: "Remote video off")),
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
                child: SizedBox(
                  width: 100,
                  height: 135,
                  child: Center(
                      child: messageController.localUserJoined.value
                          ? AgoraVideoView(
                              controller: VideoViewController(
                                rtcEngine: messageController.engine,
                                canvas: const VideoCanvas(uid: 0),
                              ),
                            )
                          : 0.height),
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
                          // onTap: messageController.setLocalVideo,
                          child: Icon(
                            messageController.localUserJoined.value
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
                          // onTap: () => messageController.setVolume(),
                          child: Icon(
                            messageController.isVolume.value
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
                          onTap: () => messageController.muteMic(),
                          child: Icon(
                            messageController.muted.value
                                ? Icons.mic_off_outlined
                                : Icons.mic_none_outlined,
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

// class VideoCallScreen extends StatefulWidget {
//   const VideoCallScreen({super.key});
//
//   @override
//   State<VideoCallScreen> createState() => _VideoCallScreenState();
// }
//
// class _VideoCallScreenState extends State<VideoCallScreen> {
//   final callCon = Get.put(CallController());
//
//   @override
//   void initState() {
//     super.initState();
//     Wakelock.enable(); // Turn on wakelock feature till call is running
//   }
//
//   @override
//   void dispose() {
//     // _engine.leaveChannel();
//     // _engine.destroy();
//     Wakelock.disable(); // Turn off wakelock feature after call end
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: Colors.black,
//           body: Obx(() => Padding(
//             padding: const EdgeInsets.all(10),
//             child: Stack(
//               children: [
//                 Center(
//                   child: callCon.localUserJoined.value == true
//                       ? callCon.videoPaused.value == true
//                       ? Container(
//                       color: Theme.of(context).primaryColor,
//                       child: Center(
//                           child: Text(
//                             "Remote Video Paused",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .titleSmall!
//                                 .copyWith(color: Colors.white70),
//                           )))
//                       : callCon.myremoteUid.value == 0
//                       ? const SizedBox()
//                       : AgoraVideoView(
//                     controller: VideoViewController.remote(
//                       rtcEngine: callCon.engine,
//                       canvas: VideoCanvas(
//                           uid: callCon.myremoteUid.value),
//                       connection: const RtcConnection(
//                           channelId: channel),
//                     ),
//                   )
//                       : const Center(
//                     child: Text(
//                       'No Remote',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//                 Align(
//                   alignment: Alignment.topLeft,
//                   child: SizedBox(
//                     width: 100,
//                     height: 150,
//                     child: Center(
//                         child: callCon.localUserJoined.value
//                             ? AgoraVideoView(
//                           controller: VideoViewController(
//                             rtcEngine: callCon.engine,
//                             canvas: const VideoCanvas(uid: 0),
//                           ),
//                         )
//                             : const CircularProgressIndicator()),
//                   ),
//                 ),
//                 Positioned(
//                   bottom: 10,
//                   left: 10,
//                   right: 10,
//                   child: Container(
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 1,
//                           child: InkWell(
//                             onTap: () {
//                               callCon.onToggleMute();
//                             },
//                             child: Icon(
//                               callCon.muted.value
//                                   ? Icons.mic
//                                   : Icons.mic_off,
//                               size: 35,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: InkWell(
//                             onTap: () {
//                               callCon.onCallEnd();
//                             },
//                             child: const Icon(
//                               Icons.call,
//                               size: 35,
//                               color: Colors.red,
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: InkWell(
//                             onTap: () {
//                               callCon.onVideoOff();
//                             },
//                             child: const CircleAvatar(
//                               backgroundColor: Colors.white,
//                               child: Padding(
//                                 padding: EdgeInsets.all(5),
//                                 child: Center(
//                                   child: Icon(
//                                     Icons.photo_camera_front,
//                                     size: 25,
//                                     color: Colors.black,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                         Expanded(
//                           flex: 1,
//                           child: InkWell(
//                             onTap: () {
//                               callCon.onSwitchCamera();
//                             },
//                             child: const Icon(
//                               Icons.switch_camera,
//                               size: 35,
//                               color: Colors.white,
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ))),
//     );
//   }
// }
