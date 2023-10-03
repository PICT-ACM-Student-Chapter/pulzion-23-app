import 'dart:ui';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';
import '../../about_us_page/ui/about_us.dart';
import '../../../constants/images.dart';
import '../../../constants/urls.dart';
import '../../../features/login_page/ui/login_signup_intro.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../features/login_page/cubit/check_login_cubit.dart';
import 'child_wild.dart';
import 'frostedglass.dart';
import 'rocket.dart';
import '../../developers_page/ui/developers_page.dart';

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
  late bool _animationstoggle;

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

  // Future<void> _launchInBrowser(Uri url) async {
  //   if (!await launchUrl(
  //     url,
  //     mode: LaunchMode.externalApplication,
  //   )) {
  //     throw Exception('Could not launch $url');
  //   }
  // }

  Future<void> _logout() async {
    await context.read<CheckLoginCubit>().logout();
    if (context.mounted) {
      await context.read<CheckLoginCubit>().checkLogin();
    }
  }

  Widget titleBar(double ht) {
    return Padding(
      padding: EdgeInsets.only(left: ht / 80, right: ht / 80),
      child: Container(
        color: Colors.transparent,
        child: Stack(children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 0.9, sigmaY: 0.9),
            child: Container(),
          ),
          ClipPath(
            clipper: PointsClipper(),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/event_frame.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: ht / 25,
              left: ht / 40,
              right: ht / 100,
              bottom: ht / 40,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => setState(() {
                    imgC = !imgC;
                  }),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(ht),
                    child: Lottie.asset(
                      imgC
                          ? "assets/images/pumpkin_cat.json"
                          : AppImages.spaceman2,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        ColorizeAnimatedText(
                          "Welcome to Pulzion '23",
                          textStyle: TextStyle(
                            fontSize: ht / 45,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                            color: Colors.white,
                          ),
                          // speed: const Duration(seconds: 2),
                          colors: [
                            const Color.fromARGB(255, 82, 50, 16)
                                .withOpacity(0.1),
                            const Color.fromARGB(255, 82, 50, 16)
                                .withOpacity(1),
                            const Color.fromARGB(255, 82, 50, 16)
                                .withOpacity(1),
                            const Color.fromARGB(255, 82, 50, 16)
                                .withOpacity(0.1),
                            // Colors.deepPurple,
                          ],
                          speed: const Duration(
                            milliseconds: 300,
                          ),
                        ),
                      ],
                      repeatForever: true,
                      pause: Duration.zero,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.005,
                    ),
                    AnimatedTextKit(
                      animatedTexts: [
                        TypewriterAnimatedText(
                          '14 Fun-filled Events',
                          textStyle: TextStyle(
                            color: const Color.fromARGB(255, 82, 50, 16)
                                .withOpacity(0.4),
                            overflow: TextOverflow.ellipsis,
                            fontSize: ht / 55,
                          ),
                          speed: const Duration(
                            milliseconds: 100,
                          ),
                        ),
                      ],
                      totalRepeatCount: 3,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    // final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
    _animationstoggle = BlocProvider.of<GlobalParameterCubit>(context).state;

    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.only(top: height / 40),
          child: Column(
            children: [
              Expanded(
                child: titleBar(
                  height - height * 0.05,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // margin: EdgeInsets.all(height / 55),
                  padding: EdgeInsets.all(height / 120),
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/event_frame.png'),
                      fit: BoxFit.fill, // Adjust this based on your needs
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: height / 90,
                      right: height / 90,
                    ),
                    child: SizedBox(
                      height: height / 11,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () {
                              _launchUniversalLinkApp(
                                Uri.parse(
                                  'https://www.instagram.com/acm.pict/',
                                ),
                              );
                            },
                            icon: const FaIcon(FontAwesomeIcons.instagram),
                            color: const Color.fromARGB(255, 82, 50, 16),
                            iconSize: height / 22,
                          ),
                          const VerticalDivider(
                            color: Colors.white54,
                          ),
                          IconButton(
                            onPressed: () {
                              _launchUniversalLinkApp(
                                Uri.parse(
                                  'https://www.linkedin.com/in/pict-acm-student-chapter-09004a132/',
                                ),
                              );
                            },
                            color: const Color.fromARGB(255, 82, 50, 16),
                            iconSize: height / 22,
                            icon: const FaIcon(FontAwesomeIcons.linkedin),
                          ),
                          const VerticalDivider(
                            color: Colors.white54,
                          ),
                          IconButton(
                            onPressed: () {
                              _launchUniversalLinkApp(
                                Uri.parse(
                                  'https://www.facebook.com/acmpict/',
                                ),
                              );
                            },
                            color: const Color.fromARGB(255, 82, 50, 16),
                            iconSize: height / 22,
                            icon: const FaIcon(FontAwesomeIcons.facebook),
                          ),
                          const VerticalDivider(
                            color: Colors.white54,
                          ),
                          IconButton(
                            onPressed: () {
                              _launchUniversalLinkApp(
                                Uri.parse(
                                  'https://twitter.com/_pict_acm_?lang=en',
                                ),
                              );
                            },
                            color: const Color.fromARGB(255, 82, 50, 16),
                            iconSize: height / 22,
                            icon: const FaIcon(FontAwesomeIcons.twitter),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              //This is for toogle animation

              // Container(
              //   height: height / 13,
              //   margin: EdgeInsets.all(height / 60),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(15),
              //     gradient: LinearGradient(
              //       begin: Alignment.topCenter,
              //       end: Alignment.bottomCenter,
              //       colors: [
              //         Colors.black.withOpacity(0.15),
              //         Colors.white.withOpacity(0.15),
              //       ],
              //     ),
              //   ),
              //   child: SwitchListTile(
              //     secondary: CircleAvatar(
              //       backgroundColor: Colors.white54,
              //       child: Icon(
              //         Icons.animation_outlined,
              //         color: Colors.black,
              //         size: height / 43,
              //       ),
              //     ),
              //     title: Text(
              //       'Toggle Animations',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //         color: Colors.white70,
              //         fontSize: height / 47,
              //       ),
              //     ),
              //     activeColor: Colors.white,
              //     inactiveThumbColor: Colors.white,
              //     inactiveTrackColor: Colors.white54,
              //     value: _animationstoggle,
              //     onChanged: (val) {
              //       BlocProvider.of<GlobalParameterCubit>(context)
              //           .toggleParameter()
              //           .then((value) => {
              //                 setState(() {
              //                   _animationstoggle = val;
              //                 }),
              //               });
              //     },
              //   ),
              // ),

              BlocBuilder<CheckLoginCubit, CheckLoginState>(
                builder: (context, state) {
                  List<List<FrostedTile>> f = [
                    [
                      FrostedTile(
                        tilename: 'Sponsors',
                        tileicon: Icons.monetization_on_outlined,
                        onTap: () {
                          launchUrl(
                            Uri.parse(EndPoints.sponsorsUrl ?? ''),
                            mode: LaunchMode.inAppWebView,
                          );
                        },
                      ),
                    ],
                    [
                      FrostedTile(
                        tilename: 'About Us',
                        tileicon: Icons.info_outline,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AboutUsPage(true),
                            ),
                          );
                        },
                      ),
                    ],
                    [
                      FrostedTile(
                        tilename: 'Developers',
                        tileicon: Icons.laptop,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const DevelopersPage(),
                            ),
                          );
                        },
                      ),
                    ],
                    [
                      FrostedTile(
                        tilename: 'Privacy Policy',
                        tileicon: Icons.privacy_tip_outlined,
                        url: EndPoints.privacyPolicyURL,
                      ),
                    ],
                    [
                      FrostedTile(
                        tilename: 'Rate us on Play Store',
                        tileicon: FontAwesomeIcons.googlePlay,
                        url: EndPoints.playStoreURL,
                      ),
                    ],
                  ];
                  if (state is CheckLoginSuccess) {
                    f.insert(
                      0,
                      [
                        FrostedTile(
                          tilename: 'Logout',
                          tileicon: Icons.person_off_outlined,
                          onTap: _logout,
                        ),
                      ],
                    );
                  }
                  if (state is CheckLoginFailure) {
                    f.insert(
                      0,
                      [
                        FrostedTile(
                          tilename: 'Sign Up',
                          tileicon: Icons.login,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginSignUpIntro(),
                              ),
                            );
                          },
                        ),
                      ],
                    );
                  }

                  return Expanded(
                    flex: 3,
                    child: Container(
                      // color: Colors.red,
                      margin: EdgeInsets.only(top: height / 70),
                      padding: EdgeInsets.only(
                        left: height / 80,
                        right: height / 80,
                      ),
                      child: AnimationLimiter(
                        child: ListView.builder(
                          itemCount: f.length,
                          itemBuilder: (context, index) =>
                              AnimationConfiguration.staggeredList(
                            position: index,
                            duration: const Duration(milliseconds: 1200),
                            child: SlideAnimation(
                              child: ScaleAnimation(
                                curve: Curves.easeInOut,
                                child: FadeInAnimation(
                                  child: FrostedGlassBox(
                                    cheight: height / 11.8,
                                    cwidth: MediaQuery.of(context).size.width,
                                    childWid: f[index],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        AnimatedOpacity(
          duration: const Duration(milliseconds: 300),
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
