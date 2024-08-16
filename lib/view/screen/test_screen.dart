import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/message/message_controller.dart';

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

  }

  @override
  void dispose() {
    // _engine.leaveChannel();
    // _engine.destroy();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(),
    );
  }
}
