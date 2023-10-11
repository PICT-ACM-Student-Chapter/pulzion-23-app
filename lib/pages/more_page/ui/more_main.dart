import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';
import 'package:pulzion23/features/splash_screen/cubit/splash_cubit.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';
import '../../../constants/styles.dart';
import '../../about_us_page/ui/about_us.dart';
import '../../../constants/urls.dart';
import '../../../features/login_page/ui/login_signup_intro.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import '../../../features/login_page/cubit/check_login_cubit.dart';
import 'child_wild.dart';
import 'frostedglass.dart';
import 'rocket.dart';
import '../../developers_page/ui/developers_page.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

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
  late bool _soundToggle;
  late bool _splashToggle;

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
    if (mounted) {
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
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                "Welcome to Pulzion",
                                textAlign: TextAlign.left,
                                textStyle: AppStyles.NormalText().copyWith(
                                  fontSize: ht / 35,
                                  fontWeight: FontWeight.bold,
                                  overflow: TextOverflow.ellipsis,
                                  color: const Color.fromARGB(255, 82, 50, 16),
                                ),
                                // speed: const Duration(seconds: 2),
                                colors: [
                                  const Color.fromARGB(255, 82, 50, 16)
                                      .withOpacity(0.5),
                                  const Color.fromARGB(255, 82, 50, 16)
                                      .withOpacity(1),
                                  const Color.fromARGB(255, 82, 50, 16)
                                      .withOpacity(1),
                                  const Color.fromARGB(255, 82, 50, 16)
                                      .withOpacity(0.5),
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
                                '10 Fun-filled Events',
                                textStyle: AppStyles.NormalText().copyWith(
                                  color: const Color.fromARGB(255, 68, 40, 10)
                                      .withOpacity(1),
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: ht / 47,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3.5,
                  child: InteractiveViewer(
                    child: const ModelViewer(
                      src: 'assets/3D/pumpkin.glb',
                      // relatedJs: '''
                      //     const modelViewer = document.querySelector('model-viewer');

                      // ''',
                      rotationPerSecond: '100deg',
                      autoPlay: true,
                      autoRotate: true,
                    ),
                  ),
                ),
                // Lottie.asset(
                //   "assets/images/potion.json",
                //   height: ht / 7,
                //   width: ht / 7,
                // ),
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
    _soundToggle = BlocProvider.of<GlobalParameterCubit>(context).controller;
    _splashToggle = BlocProvider.of<SplashCubit>(context).isSplashScreen;

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
                            color: Color.fromARGB(255, 82, 50, 16),
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
                            width: 3,
                            color: Color.fromARGB(255, 82, 50, 16),
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
                            color: Color.fromARGB(255, 82, 50, 16),
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

              //!This is for toogle animation

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

                  f.insert(0, [
                    FrostedTile(
                      tilename: "Sound",
                      tileicon: Icons.audio_file,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: SwitchListTile(
                          secondary: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: CircleAvatar(
                              maxRadius: height * 0.025,
                              backgroundColor:
                                  const Color.fromARGB(255, 82, 50, 16),
                              child: Icon(
                                Icons.music_note_outlined,
                                color: const Color.fromARGB(255, 228, 188, 136),
                                size: height * 0.025,
                              ),
                            ),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Text(
                              'Background Music',
                              style: AppStyles.NormalText().copyWith(
                                fontSize: height / 50,
                                color: const Color.fromARGB(255, 82, 50, 16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          activeColor: const Color.fromARGB(255, 196, 117, 15),
                          inactiveThumbColor: Colors.white,
                          inactiveTrackColor: Colors.grey.shade800,
                          activeTrackColor:
                              const Color.fromARGB(255, 82, 50, 16),
                          value: _soundToggle,
                          onChanged: (val) {
                            BlocProvider.of<GlobalParameterCubit>(context)
                                .toggleParameter()
                                .then((value) => {
                                      setState(() {
                                        _soundToggle = val;
                                      }),
                                    });
                          },
                        ),
                      ),
                      onTap: () {
                        BlocProvider.of<GlobalParameterCubit>(context)
                            .toggleParameter();
                      },
                    ),
                  ]);

                  f.insert(0, [
                    FrostedTile(
                      tilename: "Splash Screen",
                      tileicon: Icons.phone,
                      child: SwitchListTile(
                        secondary: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: CircleAvatar(
                            maxRadius: height * 0.025,
                            backgroundColor:
                                const Color.fromARGB(255, 82, 50, 16),
                            child: Icon(
                              Icons.phone_android,
                              color: const Color.fromARGB(255, 228, 188, 136),
                              size: height * 0.0255,
                            ),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            'Splash Screen',
                            style: AppStyles.NormalText().copyWith(
                              fontSize: height / 43,
                              color: const Color.fromARGB(255, 82, 50, 16),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        activeColor: const Color.fromARGB(255, 196, 117, 15),
                        inactiveThumbColor: Colors.white,
                        inactiveTrackColor: Colors.grey.shade800,
                        activeTrackColor: const Color.fromARGB(255, 82, 50, 16),
                        value: _splashToggle,
                        onChanged: (val) {
                          BlocProvider.of<SplashCubit>(context)
                              .toggleParameter()
                              .then((value) => {
                                    setState(() {
                                      _splashToggle = val;
                                    }),
                                  });
                        },
                      ),
                      onTap: () {
                        BlocProvider.of<SplashCubit>(context).toggleParameter();
                      },
                    ),
                  ]);

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
