import 'package:flutter/animation.dart';

class AnimationCurve extends Curve {
  @override
  double transformInternal(double t) {
    double myValue;
    if (t <= 0.5) {
      // t=0 => -(0.5 - 0.0)*2 = -1
      // t=0.1 => -(0.5 - 0.1)*2 = -0.8
      // t=0.2 => -(0.5 - 0.2)*2 = -0.6
      // t=0.3 => -(0.5 - 0.3)*2 = -0.4
      // t=0.4 => -(0.5 - 0.4)*2 = -0.2
      // t=0.5 => -(0.5 - 0.5)*2 = 0.0
      myValue = (0.5 - t) * 2;
    } else {
      // t=0.51 => -(1 - (0.55*2)) = 0.1
      // t=0.6 => -(1 - (0.6*2)) = 0.2
      // t=0.7 => -(1 - (0.7*2)) = 0.4
      // t=0.8 => -(1 - (0.8*2)) = 0.6
      // t=0.9 => -(1 - (0.9*2)) = 0.8
      // t=1 => -(1 - (1*2)) = 1.0
      myValue = -(1 - (t * 2));
    }
    //print(myValue);
    return myValue;
  }
}
