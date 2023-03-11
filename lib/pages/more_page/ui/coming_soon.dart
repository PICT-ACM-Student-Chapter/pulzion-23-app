import 'dart:ui';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:pulzion23/constants/urls.dart';
import 'package:pulzion23/features/login_page/ui/login_signup_intro.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../features/login_page/cubit/check_login_cubit.dart';
import 'child_wild.dart';
import 'frostedglass.dart';
import 'rocket.dart';
import 'more_main.dart';

class ComingSoonPage extends StatelessWidget {
  ComingSoonPage({super.key});

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
          body: Center(
            child: Image(
              image: AssetImage(
                'assets/images/ComingSoon.png',
              ),
            ),
          ),
        )
      ],
    );
  }
}
