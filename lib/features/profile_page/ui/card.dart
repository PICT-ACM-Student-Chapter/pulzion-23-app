import 'package:flutter/material.dart';

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
        Container(
          padding: EdgeInsets.only(top: h * 0.001),

          margin: EdgeInsets.only(top: h * 0.008, bottom: h * 0.01),

          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withOpacity(.2),
                const Color.fromARGB(255, 9, 45, 74).withOpacity(.1),
                Colors.white.withOpacity(.2),
              ],
            ),
            borderRadius: BorderRadius.circular(h * 0.035),
            border: Border.all(
              color: Colors.white,
              width: h * 0.001,
            ),
          ),

          height: h * 0.08,
          width: w - w * 0.15,
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
                        color: Colors.white,
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
        Positioned(
          top: h * 0.001,
          left: h * 0.04,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(h * 0.00),
              color: const Color.fromARGB(255, 28, 52, 71),
            ),
            child: Text(
              data.toString(),
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'QuickSand',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
