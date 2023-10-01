import 'package:flutter/material.dart';
import 'package:pulzion23/constants/images.dart';

Widget cardDesign(
  //design for the fields
  String data,
  double h,
  double w,
  var value,
  Widget iconWidget,
) {
  return Center(
    child: Stack(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: w / 14,
              backgroundImage: Image.asset(
                "assets/images/username.png",
              ).image,
            ),
            Container(
              padding: EdgeInsets.only(top: h * 0.001),
              margin: EdgeInsets.only(top: h * 0.008, bottom: h * 0.01),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 185, 86, 0).withOpacity(.02),
                    const Color.fromARGB(255, 9, 45, 74).withOpacity(.1),
                    Color.fromARGB(255, 185, 86, 0).withOpacity(.02),
                  ],
                ),
                // borderRadius: BorderRadius.circular(h * 0.035),
                // border: Border.all(
                //   color: Color.fromARGB(0, 69, 12, 62),
                //   width: h * 0.001,
                // ),
                image: DecorationImage(
                  image: AssetImage(AppImages.halloweenCard),
                  fit: BoxFit.fill,
                ),
              ),

              height: h * 0.1,
              width: w - w * 0.2,
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: w * 0.06),
                    child: iconWidget,
                  ),
                  SizedBox(width: w * 0.045),
                  LimitedBox(
                    maxWidth: w - w * 0.4,
                    child: FittedBox(
                      child: Center(
                        child: Text(
                          value.toString(),
                          style: TextStyle(
                            fontSize: h * 0.025,
                            color: Color.fromARGB(255, 82, 15, 16),
                            fontFamily: 'QuickSand',
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // shadowColor: Colors.amber,
            ),
          ],
        ),
        Positioned(
          top: h * 0.001,
          left: h * 0.04,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: h * 0.01),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(h * 0.01),
              color: const Color.fromARGB(255, 28, 52, 71),
            ),
            child: Text(
              data.toString(),
              style: const TextStyle(
                color: Color.fromARGB(255, 221, 218, 215),
                fontFamily: 'QuickSand',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
