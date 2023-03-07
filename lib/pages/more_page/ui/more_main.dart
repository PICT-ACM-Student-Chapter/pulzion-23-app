import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../features/login_page/cubit/check_login_cubit.dart';
import 'child_wild.dart';
import 'frostedglass.dart';
import 'rocket.dart';

class FrostedGlassTile extends StatefulWidget {
  const FrostedGlassTile({super.key});

  @override
  State<FrostedGlassTile> createState() => _FrostedGlassTileState();
}

class _FrostedGlassTileState extends State<FrostedGlassTile>
    with SingleTickerProviderStateMixin {
  bool isRocket = true;
  double _opacity = 1.0;
  bool imgC = true;

  void setRocket() {
    setState(() {
      isRocket = false;
      _opacity = 0.0;
    });
  }

  Future<void> _launchUniversalLinkApp(Uri url) async {
    final bool nativeAppLaunchSucceeded = await launchUrl(
      url,
      mode: LaunchMode.externalNonBrowserApplication,
    );
    if (!nativeAppLaunchSucceeded) {
      await launchUrl(
        url,
        mode: LaunchMode.inAppWebView,
      );
    }
  }

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  Widget titleBar(String img, String name, double ht) {
    return BlocBuilder<CheckLoginCubit, CheckLoginState>(
        builder: (context, state) {
      if (state is CheckLoginSuccess) {
        return Padding(
          padding: EdgeInsets.only(
              left: ht / 100, right: ht / 100, bottom: ht / 100),
          child: Card(
            color: Colors.transparent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ht / 25)),
            child: Stack(children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.9, sigmaY: 0.9),
                child: Container(),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(ht / 25),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.23),
                        Colors.white.withOpacity(0.05),
                      ],
                    )),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ht / 25,
                    left: ht / 50,
                    right: ht / 100,
                    bottom: ht / 50),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        imgC = !imgC;
                      }),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(ht),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Lottie.asset(
                            imgC ? AppImages.spaceman : AppImages.spaceman2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Pulzion \'23',
                          style: TextStyle(
                              fontSize: ht / 50,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            name,
                            style: TextStyle(
                              color: Colors.white54,
                              overflow: TextOverflow.ellipsis,
                              fontSize: ht / 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      } else if (state is CheckLoginFailure) {
        return Padding(
          padding: EdgeInsets.only(
              left: ht / 100, right: ht / 100, bottom: ht / 100),
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ht / 25)),
            color: Colors.transparent,
            child: Stack(children: [
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.9, sigmaY: 0.9),
                child: Container(),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ht / 25),
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.23),
                      Colors.white.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: ht / 25,
                    left: ht / 40,
                    right: ht / 100,
                    bottom: ht / 40),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() {
                        imgC = !imgC;
                      }),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(ht),
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Lottie.asset(
                            imgC ? AppImages.spaceman : AppImages.spaceman2,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Pulzion \'23',
                          style: TextStyle(
                              fontSize: ht / 50,
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.white),
                        ),
                        FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'Anonymous',
                            style: TextStyle(
                              color: Colors.white54,
                              overflow: TextOverflow.ellipsis,
                              fontSize: ht / 50,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          ),
        );
      }
      return const CircularProgressIndicator();
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height / 40),
          child: Column(
            children: [
              Expanded(
                child: titleBar('', 'Your Name', height),
              ),
              Container(
                margin: EdgeInsets.all(height / 55),
                padding: EdgeInsets.all(height / 120),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black.withOpacity(0.15),
                        Colors.white.withOpacity(0.15),
                      ],
                    )),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: height / 90, right: height / 90),
                  child: SizedBox(
                    height: height / 11,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            _launchUniversalLinkApp(Uri.parse(
                                'https://www.instagram.com/acm.pict/'));
                          },
                          icon: const FaIcon(FontAwesomeIcons.instagram),
                          color: Colors.white,
                          iconSize: height / 22,
                        ),
                        const VerticalDivider(
                          color: Colors.white54,
                        ),
                        IconButton(
                          onPressed: () {
                            _launchUniversalLinkApp(Uri.parse(
                                'https://www.linkedin.com/in/pict-acm-student-chapter-09004a132/'));
                          },
                          color: Colors.white,
                          iconSize: height / 22,
                          icon: const FaIcon(FontAwesomeIcons.linkedin),
                        ),
                        const VerticalDivider(
                          color: Colors.white54,
                        ),
                        IconButton(
                          onPressed: () {
                            _launchUniversalLinkApp(
                                Uri.parse('https://www.facebook.com/acmpict/'));
                          },
                          color: Colors.white,
                          iconSize: height / 22,
                          icon: const FaIcon(FontAwesomeIcons.facebook),
                        ),
                        const VerticalDivider(
                          color: Colors.white54,
                        ),
                        IconButton(
                          onPressed: () {
                            _launchUniversalLinkApp(Uri.parse(
                                'https://twitter.com/_pict_acm_?lang=en'));
                          },
                          color: Colors.white,
                          iconSize: height / 22,
                          icon: const FaIcon(FontAwesomeIcons.twitter),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              BlocBuilder<CheckLoginCubit, CheckLoginState>(
                builder: (context, state) {
                  if (state is CheckLoginSuccess) {
                    List<List<FrostedTile>> f = [
                      [
                        const FrostedTile(
                          tilename: 'Logout',
                          tileicon: Icons.person_off_outlined,
                        ),
                      ],
                      [
                        const FrostedTile(
                          tilename: 'Sponsors',
                          tileicon: Icons.monetization_on_outlined,
                        ),
                        const FrostedTile(
                          tilename: 'About Us',
                          tileicon: Icons.info_outline,
                        ),
                        const FrostedTile(
                          tilename: 'Developers',
                          tileicon: Icons.laptop,
                        ),
                      ],
                      [
                        FrostedTile(
                          tilename: 'Privacy Policy',
                          tileicon: Icons.privacy_tip_outlined,
                          launchURL: _launchInBrowser,
                        ),
                        FrostedTile(
                          tilename: 'Visit Website',
                          tileicon: Icons.web_outlined,
                          launchURL: _launchInBrowser,
                        ),
                        const FrostedTile(
                          tilename: 'Rate us on Play Store',
                          tileicon: FontAwesomeIcons.googlePlay,
                        ),
                      ],
                    ];

                    return Expanded(
                      flex: 3,
                      child: Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(top: height / 70),
                        padding: EdgeInsets.only(
                            left: height / 80, right: height / 80),
                        child: AnimationLimiter(
                            child: ListView.builder(
                                itemCount: f.length,
                                itemBuilder: (context, index) =>
                                    AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 2400),
                                      child: SlideAnimation(
                                        child: ScaleAnimation(
                                          curve: Curves.easeInOut,
                                          child: FadeInAnimation(
                                            child: FrostedGlassBox(
                                              cheight: height / 12.5,
                                              cwidth: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              childWid: f[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),
                    );
                  }
                  if (state is CheckLoginFailure) {
                    List<List<FrostedTile>> f = [
                      [
                        const FrostedTile(
                          tilename: 'Sign Up',
                          tileicon: Icons.login,
                        ),
                      ],
                      [
                        const FrostedTile(
                          tilename: 'Sponsors',
                          tileicon: Icons.monetization_on_outlined,
                        ),
                        const FrostedTile(
                          tilename: 'About Us',
                          tileicon: Icons.info_outline,
                        ),
                        const FrostedTile(
                          tilename: 'Developers',
                          tileicon: Icons.laptop,
                        ),
                      ],
                      [
                        FrostedTile(
                          tilename: 'Privacy Policy',
                          tileicon: Icons.privacy_tip_outlined,
                          launchURL: _launchInBrowser,
                        ),
                        FrostedTile(
                          tilename: 'Visit Website',
                          tileicon: Icons.web_outlined,
                          launchURL: _launchInBrowser,
                        ),
                        const FrostedTile(
                          tilename: 'Rate us on Play Store',
                          tileicon: FontAwesomeIcons.googlePlay,
                        ),
                      ],
                    ];

                    return Expanded(
                      flex: 3,
                      child: Container(
                        // color: Colors.red,
                        margin: EdgeInsets.only(top: height / 70),
                        padding: EdgeInsets.only(
                            left: height / 80, right: height / 80),
                        child: AnimationLimiter(
                            child: ListView.builder(
                                itemCount: f.length,
                                itemBuilder: (context, index) =>
                                    AnimationConfiguration.staggeredList(
                                      position: index,
                                      duration:
                                          const Duration(milliseconds: 2400),
                                      child: SlideAnimation(
                                        child: ScaleAnimation(
                                          curve: Curves.easeInOut,
                                          child: FadeInAnimation(
                                            child: FrostedGlassBox(
                                              cheight: height / 12.5,
                                              cwidth: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              childWid: f[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ))),
                      ),
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 500),
          opacity: _opacity,
          curve: Curves.decelerate,
          child: Rocket(
            setRocket: setRocket,
          ),
        ),
      ],
    );
  }
}
