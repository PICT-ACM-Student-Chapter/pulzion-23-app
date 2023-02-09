import 'dart:ui';

import 'package:flutter/material.dart';

class FrostedGlassBox extends StatelessWidget {
  final cwidth, cheight;
  final childWid;
  const FrostedGlassBox(
      {required this.cheight, required this.cwidth, required this.childWid});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(cheight / 7),
      child: ClipRRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Navigator.of(context).push();
            },
            child: Container(
              height: cheight,
              width: cwidth,
              color: Colors.transparent,
              child: Stack(
                children: [
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
                    child: Container(),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(cheight / 3),
                        border:
                            Border.all(color: Colors.white.withOpacity(0.1)),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.black.withOpacity(0.23),
                            Colors.black.withOpacity(0.05),
                          ],
                        )),
                  ),
                  Center(
                    child: childWid,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
