import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../colors.dart';
import '../images.dart';
import '../styles.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final Function refreshFunction;
  const ErrorDialog(this.errorMessage, this.refreshFunction, {super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: size.height * 0.35,
          width: size.width * 0.6,
          decoration: BoxDecoration(
            color: AppColors.primary.withAlpha(150),
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            border: const Border.fromBorderSide(
              BorderSide(
                color: AppColors.cardBorder,
                width: 0.2,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: size.height * 0.1),
              Text(
                'Error',
                style: AppStyles.bodyTextStyle2().copyWith(fontSize: 35),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  textAlign: TextAlign.center,
                  errorMessage,
                  style: AppStyles.bodyTextStyle3(),
                ),
              ),
              TextButton(
                onPressed: () {
                  refreshFunction();
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.white,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      'Refresh',
                      style: AppStyles.bodyTextStyle3(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: size.height * 0.165,
          child: Lottie.asset(
            AppImages.errorSpaceman,
            height: size.height * 0.35,
            width: size.width * 0.6,
          ),
        ),
      ],
    );
  }
}
