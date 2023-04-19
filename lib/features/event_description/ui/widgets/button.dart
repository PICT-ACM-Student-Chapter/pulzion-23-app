import 'package:flutter/material.dart';

import '../../../../constants/styles.dart';

class EventDescriptionPageButton extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final Function onPressed;
  const EventDescriptionPageButton(
    this.buttonText,
    this.buttonIcon,
    this.onPressed, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [Color(0xff07f49e), Color(0xff42047e)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: Text(
                  buttonText,
                  style: AppStyles.bodyTextStyle3().copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                buttonIcon,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
