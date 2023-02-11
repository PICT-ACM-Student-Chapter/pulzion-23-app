import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/models/event_model.dart';

class HomePage extends StatefulWidget {
  final Events? event;
  const HomePage({this.event,Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final event = widget.event!;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    int activeIndex = 1;
    String title = "";
    final fontSizeFactor = h / w;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.black, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 3,
            blurRadius: 9,
            offset: Offset(0, -4), // changes position of shadow
          ),
        ]),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: h / 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 3.0),
                      child: Text("PRICE",
                          style: TextStyle(color: Colors.grey, fontSize: 16)),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rs. 30",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "/person",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                        colors: [Color(0xff07f49e), Color(0xff42047e)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add to Cart  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 18),
                      ),
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                      height: h / 3,
                      child: Lottie.asset("assets/images/space.json",
                          fit: BoxFit.fill)),
                  Container(
                    height: h / 2.8,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.deepPurple.withOpacity(0.3),
                          Colors.black
                        ])),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            "assets/images/icon.png",
                            scale: 6,
                          ),
                          Text(
                            event.name!,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: fontSizeFactor * 12),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Row(
                        children: [
                          infoType(activeIndex: activeIndex, title: "Description",currentIndex: 0),
                          infoType(activeIndex: activeIndex, title: "Rounds",currentIndex: 1),
                          infoType(activeIndex: activeIndex, title: "Rules",currentIndex: 2),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: Container(
                          child: Text(
                            event.tagline!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: fontSizeFactor * 8,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFfafafa),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        child: Text(
                          event.description!,
                          style: TextStyle(
                            fontSize: fontSizeFactor * 8,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Round Details:',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          //fontFamily: 'Montserrat',
                          fontSize: fontSizeFactor * 8.5,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      event.rounds!,
                      style: TextStyle(
                        //fontFamily: 'Montserrat',
                        fontSize: fontSizeFactor * 8,
                        color: const Color(0xFFfafafa),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Rules',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          //fontFamily: 'Montserrat',
                          fontSize: fontSizeFactor * 8.5,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      event.rules!,
                      style: TextStyle(
                        //fontFamily: 'Montserrat',
                        fontSize: fontSizeFactor * 8,
                        color: const Color(0xFFfafafa),
                      ),
                    ),
                    Container(
                      child: Text(
                        'Team Details :',
                        style: TextStyle(
                          //fontFamily: 'Montserrat',
                          fontSize: fontSizeFactor * 8.5,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      event.teams!,
                      style: TextStyle(
                        //fontFamily: 'Montserrat',
                        fontSize: fontSizeFactor * 8,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: h / 12,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class infoType extends StatelessWidget {
  const infoType({
    super.key,
    required this.activeIndex,
    required this.title,
    required this.currentIndex
  });

  final int activeIndex;
  final String title;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
          color: activeIndex==currentIndex?Colors.white:Colors.grey[900],
          borderRadius:
          BorderRadius.all(Radius.circular(10.0))),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: activeIndex==currentIndex?FontWeight.bold:FontWeight.normal,
            fontSize: 18,
            color: activeIndex==currentIndex?Colors.black:Colors.grey[600]),
      ),
    );
  }
}
