import 'package:flutter/material.dart';
import 'package:pulzion23/constants/styles.dart';

Widget cardDesign(
  //design for the fields
  String data,
  double h,
  double w,
  var value,
  Widget iconWidget,
  // Image img,
) {
  return Center(
    child: Stack(
      children: [
        SingleChildScrollView(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // CircleAvatar(
              //   backgroundColor: Colors.transparent,
              //   //radius: h * 0.045,
              //   radius: h * 0.055,
              //   // child: img,
              // ),

              Container(
                // width
                padding: EdgeInsets.only(top: h * 0.001),
                margin: EdgeInsets.only(top: h * 0.02, bottom: h * 0.01),
                decoration: BoxDecoration(
                  // height: h * 0.065,
                  shape: BoxShape.rectangle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.black.withOpacity(0.4),
                      Colors.black.withOpacity(0.4),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.orange[700]!.withOpacity(0.8),
                    width: 0.7,
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1.0,
                      spreadRadius: 2.0,
                      color: Colors.yellow[900]!.withOpacity(0.3),
                    ),
                  ],

                  // image: DecorationImage(
                  //   image: AssetImage('assets/images/finaltxtbg.jpg'),
                  //   fit: BoxFit.fill,
                  //   alignment: Alignment(1, 0),
                  //
                  // ),

                  // color: Colors.transparent,
                  // borderRadius: BorderRadius.all(Radius.circular(20.0)),

                  // border: Border.all(
                  //   color: Colors.transparent,
                  //   // width: h * 0.001,
                  //   width: h * 0.001,
                  // ),
                ),

                height: h * 0.065,
                // width: w - w * 0.15,
                width: w - w * 0.10,
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
                            style: AppStyles.NormalText().copyWith(
                              fontSize: h * 0.025,
                              color: Colors.white,
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
        ),
        Positioned(
          top: h * 0.01,
          left: h * 0.04,
          // child: Container(
          //   padding: EdgeInsets.symmetric(horizontal: h * 0.01),
          //   decoration: BoxDecoration(
          // color: Colors.transparent,
          // borderRadius: BorderRadius.circular(h * 0.01),
          // color: const Color.fromARGB(255, 28, 52, 71),
          //   image: DecorationImage(
          //     image: AssetImage('assets/images/paper_torn.png'),
          //     fit: BoxFit.fill,
          //     alignment: Alignment(1, 0),
          //   ),
          //   border: Border.all(
          //     color: Colors.transparent,
          //     // width: h * 0.001,
          //     //width: h * 0.001,
          //   ),
          // ),
          child: Container(
            width: w / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromARGB(255, 227, 125, 52),
            ),
            child: Center(
              child: Text(
                (data.toString()[0].toUpperCase() +
                    data.toString().substring(1).toLowerCase()),
                style: AppStyles.NormalText().copyWith(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          //   ),
        ),
      ],
    ),
  );
}
