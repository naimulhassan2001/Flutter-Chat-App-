import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension View on num {
  Widget get height => SizedBox(height: toDouble().h);

  Widget get width => SizedBox(width: toDouble().w);
}

extension View2 on Widget {
  Widget get start => Align(
        alignment: Alignment.centerLeft,
        child: this,
      );

  Widget get end => Align(
        alignment: Alignment.centerRight,
        child: this,
      );
}
