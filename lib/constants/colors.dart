import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xff124567);
  static const Color secondary = Color(0xfff5f4f4);
  static const Color black = Color(0xff000100);
  static const Color white = Color(0xffffffff);
  static const Color cardTitleTextColor = Color.fromARGB(255, 255, 255, 255);
  static const Color cardSubtitleTextColor = Color.fromARGB(200, 255, 255, 255);
  static const Color cardBorder = Color.fromARGB(255, 88, 128, 155);
  static const Color loginPageAccent = Color(0xffac84fc);

  static final eventCardGradientList = <List<Color>>{
    [
      const Color(0xff07f49e).withAlpha(80),
      const Color(0xff42047e).withAlpha(80),
    ],
    [
      const Color(0xffe4b04d).withAlpha(80),
      const Color.fromARGB(255, 123, 71, 16).withAlpha(80),
    ],
    [
      const Color(0xffebf4f5).withAlpha(80),
      const Color.fromARGB(255, 87, 95, 107).withAlpha(80),
    ],
    [
      const Color(0xffb15b86).withAlpha(80),
      const Color(0xff440f50).withAlpha(80),
    ],
    [
      const Color(0xffef745c).withAlpha(80),
      const Color(0xff34073d).withAlpha(80),
    ],
    [
      const Color(0xff1ed7b5).withAlpha(80),
      const Color(0xfff0f9a7).withAlpha(80),
    ],
    [
      const Color(0xff6ff7e8).withAlpha(80),
      const Color(0xff1f7ea1).withAlpha(80),
    ],
    [
      const Color(0xffed71ad).withAlpha(80),
      const Color(0xff7277f1).withAlpha(80),
    ],
  };
}
