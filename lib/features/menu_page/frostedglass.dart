import 'dart:ui';

import 'package:flutter/material.dart';
import './childWid.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class FrostedGlassBox extends StatelessWidget {
  final cwidth, cheight;
  List<FrostedTile> childWid;
  FrostedGlassBox(
      {required this.cheight, required this.cwidth, required this.childWid});

  Widget FrostedItem(Widget w) {
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
                    child: w,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(cheight / 10),
      margin: EdgeInsets.all(cheight / 9),
      height: cheight * childWid.length * 1.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cheight / 4),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.black.withOpacity(0.15),
          ],
        ),
      ),
      child: AnimationLimiter(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: childWid.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 3000),
            child: ScaleAnimation(
              child: Column(
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        print('tapped');
                        // Navigator
                      },
                      child: Padding(
                        padding: EdgeInsets.all(cheight / 6),
                        child: childWid[index],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: cheight / 15, right: cheight / 15),
                    child: const Divider(
                      color: Colors.white54,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
