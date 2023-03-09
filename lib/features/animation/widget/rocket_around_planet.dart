import 'dart:math';

import 'package:flutter/material.dart';

import 'customcurve.dart';

class CustomAnimationCurve extends StatefulWidget {
  const CustomAnimationCurve({super.key});

  @override
  State<CustomAnimationCurve> createState() => _CustomAnimationCurveState();
}

class _CustomAnimationCurveState extends State<CustomAnimationCurve>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    );
    _animation =
        CurvedAnimation(parent: _animationController, curve: AnimationCurve());
    _animationController.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        height: 300,
        width: 300,
        child: Center(
          child: Container(
            height: 100,
            width: 100,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.deepPurple, Colors.blue],
              ),
            ),
            child: AnimatedBuilder(
              animation: _animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.translate(
                  offset: Offset(
                    10 * _animation.value,
                    (-20 * (_animation.value * _animation.value)),
                  ),
                  child: Transform.rotate(
                    angle: pi / 4,
                    child: const Align(
                      alignment: Alignment.bottomLeft,
                      child: Image(
                        width: 100,
                        height: 100,
                        image: AssetImage('images/rocketmain.gif'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
