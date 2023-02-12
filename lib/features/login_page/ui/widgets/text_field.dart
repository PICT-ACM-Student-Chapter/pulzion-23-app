import 'package:flutter/material.dart';
import 'package:pulzion23/constants/colors.dart';

class LoginSignUpTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  const LoginSignUpTextField(this.hintText, this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: (const TextStyle(color: Colors.white, fontWeight: FontWeight.w400)),
      cursorColor: Colors.white,
      obscureText: false,
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
          borderSide: BorderSide(color: AppColors.primary.withAlpha(255), width: 2.0),
          borderRadius: const BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      onChanged: (value) {},
    );
  }
}
