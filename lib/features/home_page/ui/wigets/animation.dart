import 'dart:async';
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
    [0, 0, 8, 7],
    [0, 2, 4, 0],
    [0, 4, 2, 1],
    [0, 6, 1, 0],
    [0, 8, 4, 6],
    [4, 0, 2, 8],
    [4, 2, 1, 8],
    [4, 4, 4, 4],
    [4, 6, 8, 8],
    [4, 8, 7, 7],
    [1, 3, 2, 8],
    [1, 8, 0, 0],
    [0, 0, 4, 4],
    [1, 2, 8, 8],
  ];
  bool isVisible = true;
  late Timer timer;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    for (int i = 1; i <= translationOffsets.length; i++) {
      Animation<Offset> translation = Tween(
        begin: Offset(
          translationOffsets[i - 1][0],
          translationOffsets[i - 1][1],
        ),
        end: Offset(translationOffsets[i - 1][2], translationOffsets[i - 1][3]),
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
