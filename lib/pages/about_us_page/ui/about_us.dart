import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulzion23/features/home_page/ui/wigets/custom_appbar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:panorama/panorama.dart';
import '../../../constants/images.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';

class AboutUsPage extends StatelessWidget {
  bool isAppbar;

  AboutUsPage(this.isAppbar, {super.key});

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

  Future<void> openWhatsAppChat(String phoneNumber) async {
    final whatsappUrl = Uri.parse('whatsapp://send?phone=$phoneNumber');
    if (!await launchUrl(whatsappUrl)) {
      throw 'Could not launch WhatsApp URL';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size;
    double height, width;
    size = MediaQuery.of(context).size;
    height = size.height;
    width = size.width;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BlocConsumer<GlobalParameterCubit, bool>(
            listener: (context, state) {},
            buildWhen: (previous, current) {
              if (previous != current) {
                return true;
              }

              return false;
            },
            builder: (context, state) {
              return Image.asset(
                AppImages.spaceBackground2,
                fit: BoxFit.cover,
              );
            },
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: isAppbar ? const CustomAppBar() : null,
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
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: width / 30,
                              top: height / 20,
                            ),
                            child: WidgetCircularAnimator(
                              size: width / 2.6,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue[900]!.withOpacity(0.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Countup(
                                      begin: 0,
                                      end: 14,
                                      duration: const Duration(seconds: 1),
                                      separator: ',',
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        color: Colors.white,
                                        fontSize: width / 13,
                                      ),
                                    ),
                                    Text(
                                      "EVENTS",
                                      style: TextStyle(
                                        fontSize: width / 26,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: width / 15, top: height / 20),
                            child: WidgetCircularAnimator(
                              size: width / 2.6,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.blue[900]!.withOpacity(0.5),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Countup(
                                      begin: 0,
                                      end: 300,
                                      duration: const Duration(seconds: 1),
                                      separator: ',',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width / 13,
                                      ),
                                    ),
                                    Text(
                                      "VOLUNTEERS",
                                      style: TextStyle(
                                        fontFamily: 'Quicksand',
                                        fontSize: width / 28,
                                        color: Colors.white,
                                      ),
                                    ),
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
                            fontFamily: 'Panther',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 20),
                        child: Text(
                          aboutPulzion,
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
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
                            fontFamily: 'Panther',
                            fontSize: width / 13,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
                                color: Colors.green,
                              ),
                              color: Colors.purpleAccent,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width / 80),
                              child: Text(
                                "Pritika Rohera",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontSize: width / 22,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Text(
                              " :  +91 80870 69750",
                              // textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: width / 20,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: height / 30),
                        child: Row(children: [
                          IconButton(
                            onPressed: () =>
                                openWhatsAppChat('+91 91563 31100'),
                            icon: const Icon(
                              FontAwesomeIcons.whatsapp,
                            ),
                            color: Colors.green,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: width / 200),
                            child: Text(
                              "Samarth Mali",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                fontFamily: 'Quicksand',
                                fontSize: width / 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Text(
                            ":  +91 91563 31100",
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: width / 20,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                      ),
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
                                color: Colors.white,
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
                                  color: Colors.white,
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
                                  color: Colors.white,
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
                                  color: Colors.white,
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
