import 'package:flutter/material.dart';
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
        const Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Image(
              image: AssetImage(
                'assets/images/ComingSoon.png',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
