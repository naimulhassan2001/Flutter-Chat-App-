import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';

class CustomButtonLoader extends StatelessWidget {
  final Color buttonColor;
  final double? buttonRadius;
  final double? buttonHeight;
  final double? buttonWidth;

  const CustomButtonLoader(
      {this.buttonColor = AppColors.primaryColor,
        this.buttonRadius,
        this.buttonHeight,
        this.buttonWidth,
        super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? 56.h,
      width: buttonWidth ?? double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(buttonColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(buttonRadius ?? 50.r),
            ),
          ),
          elevation: MaterialStateProperty.all(0),
        ),
        child: const SizedBox(
          height: 16,
          width: 16,
          child: CircularProgressIndicator(
            color: AppColors.white,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}