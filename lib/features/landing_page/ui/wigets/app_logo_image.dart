import 'package:flutter/material.dart';

import '../../../../constants/images.dart';


Widget logoWidget() {
  return const SizedBox(
    height: 100,
    width: 100,
    child: Center(
      child: Image(
        image: AssetImage(AppImages.icon),
      ),
    ),
  );
}
