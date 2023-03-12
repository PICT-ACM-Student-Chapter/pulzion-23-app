import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../images.dart';

class Loader extends StatelessWidget {
  const Loader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Lottie.asset(
      AppImages.loader,
      width: size.width * 0.7,
    );
  }
}
