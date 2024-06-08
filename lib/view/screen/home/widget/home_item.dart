import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeItem extends StatelessWidget {
  const HomeItem({
    super.key,
    required this.iconData,
    required this.isPadding,
  });

  final IconData iconData;

  final bool isPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: isPadding ? 25.h : 0),
      child: Column(
        children: [
          Icon(
            iconData,
            size: 30.sp,
          ),
        ],
      ),
    );
  }
}
