import 'package:flutter/animation.dart';

class AnimationCurve extends Curve {
  @override
  double transformInternal(double t) {
    double myValue;
    myValue = t <= 0.5 ? (0.5 - t) * 2 : -(1 - (t * 2));
    //print(myValue);

    return myValue;
  }
}
