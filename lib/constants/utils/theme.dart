import 'package:flutter/material.dart';
import 'package:pulzion23/constants/colors.dart';

class Themes {
  static ThemeData darkTheme = ThemeData(
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        textStyle: MaterialStateProperty.all(
          const TextStyle(color: AppColors.primary),
        ),
      ),
    ),
    // scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.primary,
      elevation: 0,
      titleTextStyle: TextStyle(
        fontFamily: 'Roboto',
        color: AppColors.black,
        fontWeight: FontWeight.w600,
        fontSize: 18,
      ),
      iconTheme: IconThemeData(color: AppColors.black),
    ),
    fontFamily: 'Roboto',
  );
}
