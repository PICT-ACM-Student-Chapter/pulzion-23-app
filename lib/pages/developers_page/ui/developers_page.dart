import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/images.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';

void main() {
  runApp(const MaterialApp(home: DevelopersPage()));
}

class DevelopersPage extends StatefulWidget {
  final routeName = 'developers-page';
  const DevelopersPage({super.key});

  @override
  State<DevelopersPage> createState() => _DevelopersPageState();
}

class _DevelopersPageState extends State<DevelopersPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
          _move = !_move;
        }));
    super.initState();
  }

  var count = 20;

  bool _move = true;

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

  var myProducts = [
    "Awadhoot Khutwad",
    "Soumya Garg",
    "s3",
    "s4",
    "s5",
    "s6",
    "s7",
    "s8",
    "s9"
  ];

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Stack(children: [
          Panorama(
            animSpeed: 5.0,
            child: Image.asset(AppImages.spaceBackground),
          ),
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: h * 0.06),
                child: Center(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "DEVELOPERS PAGE",
                      style: TextStyle(
                          fontSize: h * 0.04,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Divider(
                thickness: 5,
                color: Colors.white,
              ),
              AnimatedAlign(
                alignment: _move ? Alignment.centerLeft : Alignment.centerRight,
                onEnd: () => setState(() {
                  _move = !_move;
                }),
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOut,
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: Container(
                    height: 40,
                    width: 100,
                    child: Image.asset('assets/images/ufo_developer_page.gif',
                        fit: BoxFit.cover),
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).orientation ==
                            Orientation.landscape
                        ? w * 0.25
                        : w * 0.5,
                    childAspectRatio: 1 / h * 450,
                    crossAxisSpacing: h * 0.015,
                    mainAxisSpacing: h * 0.015,
                  ),
                  itemCount: myProducts.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withOpacity(.4),
                              Colors.white.withOpacity(.1)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(7.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 27, 58, 83),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              padding: EdgeInsets.all(h * 0.01),
                              // ignore: sort_child_properties_last
                              child: WidgetCircularAnimator(
                                innerAnimation: Curves.easeInCirc,
                                outerAnimation: Curves.linear,
                                innerAnimationSeconds: 5,
                                outerAnimationSeconds: 7,
                                singleRing: false,
                                innerColor: Colors.white,
                                outerColor: Colors.amber,
                                size: h * 0.170,
                                child: const CircleAvatar(
                                  backgroundColor: Colors.white24,
                                ),
                              ),
                              alignment: Alignment.topCenter,
                              height: h * 0.25,
                              // child: Image.asset(name),
                            ),
                            SizedBox(
                              height: h * 0.02,
                            ),
                            Container(
                              height: h * 0.05,
                              width: w * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(w * 0.04))),
                              child: Align(
                                alignment: Alignment.center,
                                child: FittedBox(
                                  fit: BoxFit.fitWidth,
                                  child: Text(
                                    myProducts[index],
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: h * 0.015,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  child: const Icon(
                                    FontAwesomeIcons.linkedin,
                                    color: Colors.white,
                                  ),
                                  onTap: () async {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('LINKEDIN'),
                                    ));
                                    await _launchUniversalLinkApp(
                                        'https://www.linkedin.com/in/soumya-garg-3a7453166');
                                  },
                                ),
                                SizedBox(
                                  width: w * 0.10,
                                ),
                                InkWell(
                                  child: const Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('GMAIL'),
                                    ));
                                  },
                                ),
                                SizedBox(
                                  width: w * 0.10,
                                ),
                                InkWell(
                                  child: const Icon(
                                    FontAwesomeIcons.github,
                                    color: Colors.white,
                                  ),
                                  onTap: () {
                                    ScaffoldMessenger.of(context)
                                        .hideCurrentSnackBar();
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text('GIT'),
                                    ));
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
