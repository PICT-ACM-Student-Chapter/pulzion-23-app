import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/features/login_page/ui/widgets/roundedbutton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/images.dart';
import '../../../constants/styles.dart';

class CompulsoryUpdatePage extends StatelessWidget {
  const CompulsoryUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Panorama(
          sensitivity: 0.4,
          animSpeed: 0.5,
          sensorControl: SensorControl.Orientation,
          child: Image.asset(AppImages.spaceBackground, fit: BoxFit.cover),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset(
                AppImages.astronautSayingNo,
                height: MediaQuery.of(context).size.height * 0.5,
                width: MediaQuery.of(context).size.width * 0.8,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Update Required',
                  style: AppStyles.bodyTextStyle2().copyWith(fontSize: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  textAlign: TextAlign.center,
                  'Seems like you are using an older version of the app. Please update the app to the latest version to continue using it.',
                  style: AppStyles.bodyTextStyle3().copyWith(fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: RoundedButton(
                    btnText: 'Update Now',
                    onPressed: () async {
                      if (Platform.isAndroid || Platform.isIOS) {
                        final url = Uri.parse(
                          Platform.isAndroid
                              ? "https://play.google.com/store/apps/details?id=com.pasc.pulzion2022"
                              : "https://play.google.com/store/apps/details?id=com.pasc.pulzion2022",
                        );
                        launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
