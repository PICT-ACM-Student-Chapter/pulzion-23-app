import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/widgets/halloween_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/size_config.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../constants/urls.dart';

class CompulsoryUpdatePage extends StatelessWidget {
  const CompulsoryUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return Stack(
      children: [
        Image.asset(
          AppImages.spaceBackground2,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                AppImages.zombieHand,
                height: MediaQuery.of(context).size.height * 0.3,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Update Required',
                  style: AppStyles.NormalText().copyWith(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Seems like you are using an older version of the app. Please update the app to the latest version to continue using it.',
                  style: AppStyles.NormalText().copyWith(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.05,
                    left: MediaQuery.of(context).size.width * 0.25,
                    right: MediaQuery.of(context).size.width * 0.2,
                  ),
                  child: HalloweenButton(
                    buttonText: 'Update Now',
                    icon: Icons.abc,
                    onPressed: () async {
                      if (Platform.isAndroid || Platform.isIOS) {
                        final url = Uri.parse(
                          EndPoints.playStoreURL ?? 'https://pulzion.co.in',
                        );
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
