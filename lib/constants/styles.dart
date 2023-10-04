import 'package:flutter/material.dart';

import '../config/size_config.dart';
import 'colors.dart';

class AppStyles {
  static TextStyle bodyTextStyle1() {
    return TextStyle(
      fontSize: SizeConfig.getProportionateScreenFontSize(30),
      fontWeight: FontWeight.normal,
      fontFamily: 'Roboto',
      color: AppColors.black,
    );
  }

  static TextStyle bodyTextStyle2() {
    return TextStyle(
      fontSize: SizeConfig.getProportionateScreenFontSize(15),
      fontWeight: FontWeight.w600,
      fontFamily: 'Panther',
      color: AppColors.cardTitleTextColor,
    );
  }

  static TextStyle bodyTextStyle3() {
    return TextStyle(
      fontSize: SizeConfig.getProportionateScreenFontSize(12),
      fontWeight: FontWeight.normal,
      fontFamily: 'QuickSand',
      color: AppColors.cardSubtitleTextColor,
    );
  }

  static TextStyle bodyTextStyle4() {
    return TextStyle(
      fontSize: SizeConfig.getProportionateScreenFontSize(15),
      fontWeight: FontWeight.w500,
      fontFamily: 'Panther',
      color: AppColors.cardTitleTextColor,
    );
  }

  static TextStyle bodyTextStyle5() {
    return TextStyle(
      fontSize: SizeConfig.getProportionateScreenFontSize(15),
      fontWeight: FontWeight.bold,
      fontFamily: 'QuickSand',
      color: AppColors.white,
    );
  }

  static TextStyle NormalText() {
    return TextStyle(
      fontSize: SizeConfig.getProportionateScreenFontSize(30),
      fontWeight: FontWeight.normal,
      fontFamily: 'Gothica-Book',
      color: AppColors.black,
    );
  }

  static TextStyle TitleText() {
    return TextStyle(
      fontSize: SizeConfig.getProportionateScreenFontSize(15),
      fontWeight: FontWeight.w600,
      fontFamily: 'Danger-Night',
      color: AppColors.cardTitleTextColor,
    );
  }

}
