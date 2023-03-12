import 'dart:developer';

import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;

  static init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenHeight = _mediaQueryData!.size.height;
    screenWidth = _mediaQueryData!.size.width;
    orientation = _mediaQueryData!.orientation;

    log("Screen Height: $screenHeight");
    log("Screen Width: $screenWidth");
  }

  static double getProportionateScreenHeight(double inputHeight) {
    double? screenHeight = SizeConfig.screenHeight;
    // 932 is the layout height that designer use

    return (inputHeight / 932.0) * screenHeight!;
  }

  static double getProportionateScreenWidth(double inputWidth) {
    double? screenWidth = SizeConfig.screenWidth;
    // 430 is the layout Width that designer use

    return (inputWidth / 430.0) * screenWidth!;
  }

  static double getProportionateScreenFontSize(double inputFontSize) {
    double? screenWidth = SizeConfig.screenWidth;

    return (inputFontSize / 430.0) * screenWidth!;
  }
}
