import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Rocket extends StatefulWidget {
  Function setRocket;
  Rocket({required this.setRocket});
  @override
  State<Rocket> createState() => _MyAppState();
}

class _MyAppState extends State<Rocket> {
  bool a = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 5))
        .then((value) => setState(() {
              a = !a;
            }));
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animation',
      color: Colors.black,
      home: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: h * 0.65,
                width: w,
                child: Stack(children: [
                  AnimatedAlign(
                    onEnd: () {
                      setState(() {
                        widget.setRocket();
                      });
                    },
                    duration: const Duration(milliseconds: 2400),
                    alignment: a ? Alignment.bottomCenter : Alignment.topCenter,
                    child: Transform.rotate(
                      angle: pi,
                      child:Lottie.asset('assets/images/rocket_more_page.json', height: 100, width: 100),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
