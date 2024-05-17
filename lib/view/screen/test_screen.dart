import 'package:flutter/material.dart';

import '../common_widgets/button/custom_button.dart';
import '../common_widgets/custom_button_loader.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: CustomButton(
                titleText: "titleText",
                onTap: () {
                  const CustomButtonLoader();
                  setState(() {});
                })));
  }
}
