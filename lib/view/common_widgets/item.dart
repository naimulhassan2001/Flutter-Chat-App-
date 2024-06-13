import 'package:flutter/material.dart';
import 'package:flutter_chat_app/extension/extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_colors.dart';
import 'image/custom_image.dart';
import 'text/custom_text.dart';

class Item extends StatelessWidget {
  const Item(
      {super.key,
      this.icon,
      required this.title,
      this.image = "",
      this.disableDivider = false,
      this.onTap,
      this.color = AppColors.black,
      this.iconColor = AppColors.black,
      this.vertical,
      this.disableIcon = false});

  final IconData? icon;
  final String title;
  final String image;
  final bool disableDivider;
  final bool disableIcon;
  final VoidCallback? onTap;
  final Color color;
  final Color iconColor;
  final double? vertical;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: vertical ?? 6.h),
        child: Column(
          children: [
            Row(
              children: [
                icon != null
                    ? Icon(
                        icon,
                        color: iconColor,
                      )
                    : CustomImage(imageSrc: image),
                CustomText(
                  text: title,
                  color: color,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.sp,
                  left: 16.w,
                ),
                const Spacer(),
                disableIcon
                    ? 0.height
                    : Icon(
                        Icons.arrow_forward_ios_outlined,
                        size: 20.sp,
                      )
              ],
            ),
            6.height,
            disableDivider ? 0.height : const Divider()
          ],
        ),
      ),
    );
  }
}
