import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';

import '../../../constants/images.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

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
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Lottie.asset(
                  'assets/images/coming_soon.json',
                  height: MediaQuery.of(context).size.height * 0.4,
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.height * 0.15,
                  left: -MediaQuery.of(context).size.width * 0.25,
                  child: Image.asset(
                    'assets/images/ComingSoon.png',
                    height: MediaQuery.of(context).size.height * 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
