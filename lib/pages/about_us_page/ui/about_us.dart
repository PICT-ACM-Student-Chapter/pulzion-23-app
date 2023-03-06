import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:countup/countup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  final String aboutPulzion =
      "Pulzion is the annual technical fest organized by PICT ACM Student Chapter. Pulzion has hosted multiple events including coding competition ranging from amateur competitions two day-long as well as mock placements, business management based and quizzing events. It has become one of the most anticipated events taking place at PICT with participants from colleges all over Pune. With high aspirations, backed with sincerity and dedication, the PASC team aims to add value to the college and all the people in it.";

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(width / 20),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(width: 2.0, color: Colors.blue),
              ),
              height: height / 8,
              width: width / 1.8,
              child: Image.asset(
                "assets/images/pasc_logo.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width / 30, top: height / 20),
                  child: WidgetCircularAnimator(
                    size: width / 2.6,
                    child: Container(
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                      child: Row(
                        children: [
                          Column(children: [
                            Padding(
                              padding: EdgeInsets.only(top: width / 30, left: width / 20),
                              child: Countup(
                                begin: 0,
                                end: 16,
                                duration: Duration(seconds: 1),
                                separator: ',',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width / 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 17, top: width / 36),
                              child: Text(
                                "EVENTS",
                                style: TextStyle(fontSize: width / 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: width / 15, top: height / 20),
                  child: WidgetCircularAnimator(
                    size: width / 2.6,
                    child: Container(
                      decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                      child: Row(
                        children: [
                          Column(children: [
                            Padding(
                              padding: EdgeInsets.only(top: width / 30, left: width / 45),
                              child: Countup(
                                begin: 0,
                                end: 600,
                                duration: Duration(seconds: 1),
                                separator: ',',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: width / 13,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: width / 36, left: width / 40),
                              child: Text(
                                "VOLUNTEERS",
                                style: TextStyle(
                                  fontSize: width / 27,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 20),
              child: Text(
                "ABOUT PULZION",
                style: TextStyle(
                    fontSize: width / 12, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 20),
              child: Text(
                aboutPulzion,
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: width / 19,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 20),
              child: Text(
                "CONTACT US",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: width / 12, color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 35, left: width / 30),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.phone,
                  size: width / 12,
                  color: Colors.purpleAccent[100],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height / 30),
              child: Text(
                "Ashutosh Shaha - (+91) 9156546280\nSiddhi Wakchaure - (+91) 8329368540",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: width / 20,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: height / 20),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: width / 15),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.facebook,
                          size: width / 10,
                          color: Colors.purpleAccent[100],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 12),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.instagram,
                          size: width / 10,
                          color: Colors.purpleAccent[100],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 12),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.linkedin,
                          size: width / 10,
                          color: Colors.purpleAccent[100],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width / 12),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          FontAwesomeIcons.twitter,
                          size: width / 10,
                          color: Colors.purpleAccent[100],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
