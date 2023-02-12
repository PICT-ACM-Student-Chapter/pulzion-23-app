import 'package:flutter/material.dart';
import 'package:panorama/panorama.dart';

import '../images.dart';

class AnimatedBackground extends StatefulWidget {
  AnimatedBackground({super.key});

  @override
  State<AnimatedBackground> createState() => _AnimatedBackgroundState();
}

class _AnimatedBackgroundState extends State<AnimatedBackground> {
  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

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
        //Scaffold
      ],
    );
  }
}
