import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulzion23/features/home_page/ui/wigets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/styles.dart';

import 'dart:math';

class AboutUsPage extends StatefulWidget {
  bool isAppbar;

  AboutUsPage(this.isAppbar, {super.key});

  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage>
    with SingleTickerProviderStateMixin {
  final String aboutPulzion =
      "Pulzion is the annual technical fest organized by PICT ACM Student Chapter. Pulzion has hosted multiple events including coding competition ranging from amateur competitions two day-long as well as mock placements, business management based and quizzing events. It has become one of the most anticipated events taking place at PICT with participants from colleges all over Pune. With high aspirations, backed with sincerity and dedication, the PASC team aims to add value to the college and all the people in it.";

  AnimationController? _animationController;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    if (_animationController == null) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(
          seconds: 100,
        ),
      ); // Reduced the duration for faster rotation

      _rotation = Tween(begin: 0.0, end: 2 * pi).animate(_animationController!);

      _animationController?.repeat();
    } else {
      print('');
    }
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

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

  Future<void> openWhatsAppChat(String phoneNumber) async {
    final whatsappUrl = Uri.parse('whatsapp://send?phone=$phoneNumber');
    if (!await launchUrl(whatsappUrl)) {
      throw 'Could not launch WhatsApp URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    _animationController?.repeat();
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/app_background.jpeg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: widget.isAppbar ? const CustomAppBar() : null,
              body: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(width / 20),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: height / 50),
                        child: SizedBox(
                          height: height / 10,
                          width: width / 2,
                          child: Image.asset(
                            "assets/images/pasc_logo.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 20),
                        child: Container(
                          decoration: BoxDecoration(
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
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "ABOUT PULZION",
                                style: AppStyles.NormalText().copyWith(
                                  fontSize: width / 12,
                                  // fontFamily: 'Panther',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height * 0.05),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                Positioned(
                                  top: height / 27,
                                  left: width / 34.3,
                                  child: Container(
                                    // height: 95.0,
                                    // width: 95.0,
                                    height: height / 8,
                                    width: width / 2.6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 228, 188, 136),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Countup(
                                          begin: 0,
                                          end: 10,
                                          duration: const Duration(seconds: 1),
                                          separator: ',',
                                          style:
                                              AppStyles.NormalText().copyWith(
                                            // fontFamily: 'Quicksand',
                                            color: Colors.black,
                                            fontSize: width / 13,
                                          ),
                                        ),
                                        Text(
                                          "EVENTS",
                                          style:
                                              AppStyles.NormalText().copyWith(
                                            fontSize: width / 26,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                RotationTransition(
                                  turns: _rotation,
                                  child: SizedBox(
                                    width: width / 2.26,
                                    child: Image.asset(
                                        "assets/images/aboutusframe.png"),
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              children: [
                                Positioned(
                                  top: height / 27,
                                  right: width / 34.3,
                                  child: Container(
                                    height: height / 8,
                                    width: width / 2.6,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.fromARGB(255, 228, 188, 136),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Countup(
                                          begin: 0,
                                          end: 300,
                                          duration: const Duration(seconds: 1),
                                          separator: ',',
                                          style:
                                              AppStyles.NormalText().copyWith(
                                            color: Colors.black,
                                            fontSize: width / 13,
                                          ),
                                        ),
                                        Text(
                                          "VOLUNTEERS",
                                          style:
                                              AppStyles.NormalText().copyWith(
                                            // fontFamily: 'Quicksand',
                                            fontSize: width / 28,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                RotationTransition(
                                  turns: _rotation,
                                  child: SizedBox(
                                    width: width / 2.26,
                                    child: Image.asset(
                                        "assets/images/aboutusframe.png"),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 20),
                        child: Text(
                          aboutPulzion,
                          textAlign: TextAlign.justify,
                          style: AppStyles.NormalText().copyWith(
                            // fontFamily: ,
                            fontSize: width / 19,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 20),
                        child: Container(
                          width: height / 4,
                          decoration: BoxDecoration(
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
                          ),
                          child: Center(
                            child: Text(
                              "CONTACT US",
                              textAlign: TextAlign.justify,
                              style: AppStyles.NormalText().copyWith(
                                // fontFamily: 'Panther',
                                fontSize: width / 13,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 30),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: () =>
                                  openWhatsAppChat('+91 80870 69750'),
                              icon: const Icon(
                                FontAwesomeIcons.whatsapp,
                                color: Color.fromARGB(255, 196, 95, 13),
                              ),
                              color: Colors.purpleAccent,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 80),
                              child: Text(
                                "Pritika Rohera",
                                textAlign: TextAlign.center,
                                style: AppStyles.NormalText().copyWith(
                                  fontSize: width / 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              " :  +91 80870 69750",
                              // textAlign: TextAlign.justify,
                              style: AppStyles.NormalText().copyWith(
                                // fontFamily: 'Quicksand',
                                fontSize: width / 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(children: [
                        IconButton(
                          onPressed: () => openWhatsAppChat('+91 91563 31100'),
                          icon: const Icon(
                            FontAwesomeIcons.whatsapp,
                          ),
                          color: const Color.fromARGB(255, 196, 95, 13),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: width / 200),
                          child: Text(
                            "Samarth Mali",
                            textAlign: TextAlign.justify,
                            style: AppStyles.NormalText().copyWith(
                              // fontFamily: 'Quicksand',
                              fontSize: width / 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Text(
                          ":  +91 91563 31100",
                          textAlign: TextAlign.justify,
                          style: AppStyles.NormalText().copyWith(
                            // fontFamily: 'Quicksand',
                            fontSize: width / 20,
                            color: Colors.white,
                          ),
                        ),
                      ]),
                      Padding(
                        padding: EdgeInsets.only(top: height / 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () async {
                                await _launchUniversalLinkApp(
                                  "https://www.facebook.com/acmpict/",
                                );
                              },
                              icon: Icon(
                                FontAwesomeIcons.facebook,
                                size: width / 10,
                                color: const Color.fromARGB(255, 196, 95, 13),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 12),
                              child: IconButton(
                                onPressed: () async {
                                  await _launchUniversalLinkApp(
                                    'https://www.instagram.com/acm.pict/?hl=en',
                                  );
                                },
                                icon: Icon(
                                  FontAwesomeIcons.instagram,
                                  size: width / 10,
                                  color: const Color.fromARGB(255, 196, 95, 13),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 12),
                              child: IconButton(
                                onPressed: () async {
                                  await _launchUniversalLinkApp(
                                    "https://in.linkedin.com/company/pict-acm-student-chapter",
                                  );
                                },
                                icon: Icon(
                                  FontAwesomeIcons.linkedin,
                                  size: width / 10,
                                  color: const Color.fromARGB(255, 196, 95, 13),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 12),
                              child: IconButton(
                                onPressed: () async {
                                  await _launchUniversalLinkApp(
                                    "https://twitter.com/_pict_acm_?lang=en",
                                  );
                                },
                                icon: Icon(
                                  FontAwesomeIcons.twitter,
                                  size: width / 10,
                                  color: const Color.fromARGB(255, 196, 95, 13),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
