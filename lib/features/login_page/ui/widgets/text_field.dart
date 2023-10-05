import 'dart:ui';

import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/styles.dart';

class LoginSignUpTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;

  LoginSignUpTextField(
    this.hintText,
    this.icon, {
    super.key,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 7, bottom: 7),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black.withOpacity(0.6),
              Colors.black.withOpacity(0.4),
              Colors.black.withOpacity(0.4),
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Colors.orange[700]!.withOpacity(0.8),
            width: 0.7,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: 1.0,
              spreadRadius: 2.0,
              color: Colors.yellow[900]!.withOpacity(0.3),
            ),
          ],
        ),
        child: TextField(
          obscureText: obscureText,
          textInputAction: TextInputAction.next,
          style: (AppStyles.NormalText().copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          )),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyles.NormalText().copyWith(
              color: Colors.white,
              fontSize: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            // fillColor: AppColors.primary.withAlpha(100),
            filled: true,
            prefixIcon: Icon(
              icon,
              color: Colors.white,
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
            ),
          ),
          controller: controller,
        ),
      ),
    );
  }
}
