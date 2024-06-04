import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/app_colors.dart';
import '../custom_button_loader.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String titleText;

  final Color titleColor;
  final Color buttonColor;
  final Color? borderColor;
  final FontWeight titleWeight;

  final double? borderWidth;
  final double? titleSize;
  final double? buttonRadius;
  final double? buttonHeight;
  final double? buttonWidth;
  final bool isLoading;

  const CustomButton(
      {this.onTap,
        required this.titleText,
        this.titleColor = AppColors.white,
        this.buttonColor = AppColors.primaryColor,
        this.titleSize,
        this.buttonRadius,
        this.titleWeight = FontWeight.w700,
        this.buttonHeight,
        this.borderWidth,
        this.isLoading = false,
        this.buttonWidth = double.infinity,
        this.borderColor = AppColors.primaryColor,
        super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: buttonHeight ?? 58.h,
      width: buttonWidth,
      child: isLoading
          ? CustomButtonLoader(
        buttonHeight: buttonHeight,
        buttonColor: buttonColor,
        buttonRadius: buttonRadius,
        buttonWidth: buttonWidth,
      )
          : ElevatedButton(
        onPressed: onTap,
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(buttonColor),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(buttonRadius ?? 50.r),
                side: BorderSide(
                    color: borderColor ?? AppColors.primaryColor,
                    width: borderWidth ?? 1.w),
              ),
            ),
            elevation: MaterialStateProperty.all(0)),
        child: Text(
          titleText,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style:TextStyle(
              color: titleColor,
              fontSize: titleSize ?? 16.sp,
              fontWeight: titleWeight),
        ),
      ),
    );
  }
}