import 'package:flutter/material.dart';

import 'colors.dart';

class AppStyles {
  static TextStyle bodyTextStyle1() {
    return const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto',
      color: AppColors.black,
    );
  }

  static TextStyle bodyTextStyle2() {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      fontFamily: 'Panther',
      color: AppColors.cardTitleTextColor,
    );
  }

  static TextStyle bodyTextStyle3() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.normal,
      fontFamily: 'QuickSand',
      color: AppColors.cardSubtitleTextColor,
    );
  }

  static TextStyle bodyTextStyle4() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      fontFamily: 'Panther',
      color: AppColors.cardTitleTextColor,
    );
  }

  static TextStyle bodyTextStyle5() {
    return const TextStyle(
      fontSize: 15,
      fontWeight: FontWeight.bold,
      fontFamily: 'QuickSand',
      color: AppColors.white,
    );
  }
}
