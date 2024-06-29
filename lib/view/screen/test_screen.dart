import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wakelock/wakelock.dart';

import '../../controller/message/message_controller.dart';
import '../../utils/payment_key.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final callCon = Get.put(MessageController());

  @override
  void initState() {
    super.initState();

    Wakelock.enable(); // Turn on wakelock feature till call is running
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
                              : callCon.myremoteUid.value == 0
                                  ? const SizedBox()
                                  : AgoraVideoView(
                                      controller: VideoViewController.remote(
                                        rtcEngine: callCon.engine,
                                        canvas: VideoCanvas(
                                            uid: callCon.myremoteUid.value),
                                        connection: const RtcConnection(
                                            channelId: channel),
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
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: InkWell(
                                onTap: () {},
                                child: Icon(
                                  callCon.muted.value
                                      ? Icons.mic
                                      : Icons.mic_off,
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
                                onTap: () {},
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
                                onTap: () {},
                                child: const Icon(
                                  Icons.switch_camera,
                                  size: 35,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ))),
    );
  }
}
