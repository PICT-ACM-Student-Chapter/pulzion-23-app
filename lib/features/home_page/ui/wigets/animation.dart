import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TranslateImage extends StatefulWidget {
  const TranslateImage({super.key});

  @override
  State<TranslateImage> createState() => _TranslateImageState();
}

class _TranslateImageState extends State<TranslateImage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late List<Animation<Offset>> ani = [];
  List<List<double>> translationOffsets = [
    // [0, 0, 8, 7],
    // [0, 2, 4, 0],
    // [0, 4, 2, 1],
    // [0, 6, 1, 0],
    // [0, 8, 4, 6],
    // [4, 0, 2, 8],
    // [4, 2, 1, 8],
    // [4, 4, 4, 4],
    // [4, 6, 8, 8],
    // [4, 8, 7, 7],
    // [1, 3, 2, 8],
    // [1, 8, 0, 0],
    // [0, 0, 4, 4],
    // [1, 2, 8, 8],
  ];
  bool isVisible = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    Random random = Random();

    for (int i = 0; i < 16; i++) {
      List<double> offsetValues = [
        random.nextDouble() * 8,
        random.nextDouble() * 8,
        random.nextDouble() * 8,
        random.nextDouble() * 8,
      ];

      Animation<Offset> translation = Tween(
        begin: Offset(offsetValues[0], offsetValues[1]),
        end: Offset(offsetValues[2], offsetValues[3]),
      ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
      );

      ani.add(translation);
    }

    _animationController.repeat();

    timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        isVisible = false;
      });
    });
  }

  @override
  void dispose() {
    timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 1000),
        color: Colors.transparent,
        child: Stack(
          children: ani.map((e) {
            return SlideTransition(
              position: e,
              child: SizedBox(
                width: 100,
                child: Lottie.asset("assets/images/skull.json"),
              ),
            );
          }).toList(),
          // Add other SlideTransition widgets for _Translation2 to _Translation16
        ),
      ),
    );
  }
}
