import 'package:flutter/material.dart';
import '../../../../constants/colors.dart';

class LoginSignUpTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool obscureText;

  const LoginSignUpTextField(
    this.hintText,
    this.icon, {
    super.key,
    required this.controller,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      textInputAction: TextInputAction.next,
      style:
          (const TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
      cursorColor: Colors.white,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.white,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        fillColor: AppColors.primary.withAlpha(100),
        filled: true,
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColors.primary.withAlpha(255), width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      controller: controller,
    );
  }
}
