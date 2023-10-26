import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../colors.dart';
import '../images.dart';
import '../styles.dart';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? refreshFunction;

  const ErrorDialog(
    this.errorMessage, {
    super.key,
    this.refreshFunction,
  });

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
          // decoration: BoxDecoration(
          //   color: Colors.orange.shade600.withOpacity(0.4),
          //   borderRadius: const BorderRadius.all(
          //     Radius.circular(20),
          //   ),
          //   border: const Border.fromBorderSide(
          //     BorderSide(
          //       color: AppColors.cardBorder,
          //       width: 0.2,
          //     ),
          //   ),
          // ),
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
                  style: AppStyles.NormalText().copyWith(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  if (refreshFunction != null) {
                    refreshFunction!();
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.refresh_rounded,
                      color: AppColors.white,
                    ),
                    const SizedBox(width: 7),
                    Text(
                      textAlign: TextAlign.center,
                      'Retry',
                      style: AppStyles.NormalText().copyWith(
                        fontSize: 25,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: size.height * 0.195,
          right: -size.width * 0.03,
          child: Lottie.asset(
            AppImages.errorSpaceman,
            height: size.height * 0.3,
            width: size.width * 0.65,
          ),
        ),
      ],
    );
  }
}
