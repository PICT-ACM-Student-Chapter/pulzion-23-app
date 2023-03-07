import 'package:flutter/material.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:countup/countup.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panorama/panorama.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'About us',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const About_us(title: 'About_us'),
    );
  }
}

class About_us extends StatefulWidget {
  const About_us({super.key, required String title});

  @override
  State<About_us> createState() => _About_usState();
}

class _About_usState extends State<About_us> {
  final String aboutPulzion =
      "Pulzion is the annual technical fest organized by PICT ACM Student Chapter. Pulzion has hosted multiple events including coding competition ranging from amateur competitions two day-long as well as mock placements, business management based and quizzing events. It has become one of the most anticipated events taking place at PICT with participants from colleges all over Pune. With high aspirations, backed with sincerity and dedication, the PASC team aims to add value to the college and all the people in it.";

  Future<void> _launchUniversalLinkApp(String url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    var size, height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;
    final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
    return Scaffold(
      // backgroundColor: Color.fromARGB(207, 114, 24, 183),
      // appBar: AppBar(
      //   title: Center(child: Text("ABOUT US")),
      // ),
      body: Stack(
        children: [
          Panorama(
            animSpeed: 0.5,
            sensorControl: SensorControl.Orientation,
            child: Image.asset('assets/images/space1.jpg', fit: BoxFit.cover),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(width / 20),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: height / 40),
                    child: Container(
                        height: height / 15,
                        width: width / 1.2,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.white.withOpacity(.7),
                                Color.fromARGB(255, 126, 181, 205)
                                    .withOpacity(.7),
                                Colors.white.withOpacity(.7),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(width / 10)),
                        child: Center(
                          child: Text(
                            "ABOUT US",
                            style: TextStyle(
                                fontSize: width / 10,
                                color: Color.fromARGB(255, 11, 38, 77),
                                fontWeight: FontWeight.bold),
                          ),
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: height / 30),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(width / 20),
                        border: Border.all(width: 2.0, color: Colors.blue),
                      ),
                      height: height / 10,
                      width: width / 2,
                      child: Image.asset(
                        "assets/images/pasc_logo.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(left: width / 30, top: height / 20),
                        child: WidgetCircularAnimator(
                          size: width / 2.6,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 239, 170, 150)),
                            child: Row(
                              children: [
                                Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: width / 30, left: width / 20),
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
                                    padding: EdgeInsets.only(
                                        left: width / 17, top: width / 36),
                                    child: Text(
                                      "EVENTS",
                                      style: TextStyle(
                                          fontSize: width / 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(left: width / 15, top: height / 20),
                        child: WidgetCircularAnimator(
                          size: width / 2.6,
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 239, 170, 150)),
                            child: Row(
                              children: [
                                Column(children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: width / 30, left: width / 45),
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
                                    padding: EdgeInsets.only(
                                        top: width / 36, left: width / 40),
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
                          fontSize: width / 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
                          fontSize: width / 12,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: height / 35, left: width / 30),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              await _launchUniversalLinkApp(
                                  "https://www.facebook.com/acmpict/");
                            },
                            icon: Icon(
                              FontAwesomeIcons.facebook,
                              size: width / 10,
                              color: Colors.purpleAccent[100],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width / 12),
                            child: IconButton(
                              onPressed: () async {
                                await _launchUniversalLinkApp(
                                    'https://www.instagram.com/acm.pict/?hl=en');
                              },
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
                              onPressed: () async {
                                await _launchUniversalLinkApp(
                                    "https://in.linkedin.com/company/pict-acm-student-chapter");
                              },
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
                              onPressed: () async {
                                await _launchUniversalLinkApp(
                                    "https://twitter.com/_pict_acm_?lang=en");
                              },
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
          ),
        ],
      ),
    );
  }
}
