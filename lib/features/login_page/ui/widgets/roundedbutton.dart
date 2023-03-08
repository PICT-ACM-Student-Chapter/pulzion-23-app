import 'package:flutter/material.dart';
import 'package:pulzion23/constants/styles.dart';

import '../../../../constants/colors.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, required this.btnText, required this.onPressed});

  final String btnText;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: size.height * 0.06,
        width: size.width * 0.35,
        decoration: BoxDecoration(
          color: AppColors.primary.withAlpha(200),
          borderRadius: const BorderRadius.all(
            Radius.circular(25),
          ),
          border: const Border.fromBorderSide(
            BorderSide(
              color: AppColors.cardBorder,
              width: 1,
            ),
          ),
        ),
        child: Center(
          child: Text(
            btnText,
            style: AppStyles.bodyTextStyle3()
                .copyWith(fontSize: 20, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
