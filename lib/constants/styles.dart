import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import 'colors.dart';

class AppStyles {
  static TextStyle bodyTextStyle1() {
    return TextStyle(
      fontSize: 30.sp,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto',
      color: AppColors.black,
    );
  }

  static TextStyle bodyTextStyle2() {
    return TextStyle(
      fontSize: 20.sp,
      fontWeight: FontWeight.w600,
      fontFamily: 'Panther',
      color: AppColors.cardTitleTextColor,
    );
  }

  static TextStyle bodyTextStyle3() {
    return TextStyle(
      fontSize: 12.sp,
      fontWeight: FontWeight.normal,
      fontFamily: 'QuickSand',
      color: AppColors.cardSubtitleTextColor,
    );
  }

  static TextStyle bodyTextStyle4() {
    return TextStyle(
      fontSize: 15.sp,
      fontWeight: FontWeight.w500,
      fontFamily: 'Panther',
      color: AppColors.cardTitleTextColor,
    );
  }
}
