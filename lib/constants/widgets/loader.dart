import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../images.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      AppImages.loader,
      // height: size.height * 0.35,
      // width: size.width * 0.6,
    );
  }
}
