import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/styles.dart';
import '../../../features/home_page/ui/wigets/custom_appbar.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panorama/panorama.dart';
import 'info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/images.dart';
import 'package:bloc/bloc.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';

class DevelopersPage extends StatefulWidget {
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

  var developersList = data;
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

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;

    return Stack(
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
            return Panorama(
              sensitivity: 0.4,
              animSpeed: 0.5,
              sensorControl:
                  state ? SensorControl.Orientation : SensorControl.None,
              child: Image.asset(
                AppImages.spaceBackground,
                fit: BoxFit.cover,
              ),
            );
          },
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(
                          left: h * 0.05,
                          right: h * 0.05,
                          top: h * 0.02,
                          bottom: h * 0.015,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(h * 0.03),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.3),
                              Colors.white.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: FittedBox(
                          clipBehavior: Clip.hardEdge,
                          fit: BoxFit.contain,
                          child: Text(
                            "Developers Page",
                            style: AppStyles.bodyTextStyle2()
                                .copyWith(fontSize: 25),
                          ),
                        ),
                      ),
                    ),
                  ),
                  AnimatedAlign(
                    alignment:
                        _move ? Alignment.centerLeft : Alignment.centerRight,
                    onEnd: () => setState(() {
                      _move = !_move;
                    }),
                    duration: const Duration(seconds: 3),
                    curve: Curves.easeInOut,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SizedBox(
                        height: h * 0.04,
                        width: h * 0.1,
                        child: Image.asset(
                          'assets/images/ufo_developer_page.gif',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? w * 0.25
                                : w * 0.5,
                        childAspectRatio: 1 / h * 450,
                        crossAxisSpacing: h * 0.015,
                        mainAxisSpacing: h * 0.015,
                      ),
                      itemCount: developersList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(.4),
                                Colors.white.withOpacity(.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(7.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 27, 58, 83),
                                    borderRadius: BorderRadius.circular(17),
                                  ),
                                  padding: EdgeInsets.all(h * 0.005),
                                  alignment: Alignment.topCenter,
                                  height: h * 0.25,
                                  child: WidgetCircularAnimator(
                                    innerAnimation: Curves.easeInCirc,
                                    outerAnimation: Curves.linear,
                                    innerAnimationSeconds: 5,
                                    outerAnimationSeconds: 7,
                                    singleRing: false,
                                    innerColor: Colors.white,
                                    outerColor: Colors.amber,
                                    size: h * 0.170,
                                    child: CircleAvatar(
                                      //Images of the developer need to be added  here
                                      // ignore: sort_child_properties_last
                                      radius: 20,
                                      foregroundImage: NetworkImage(
                                        developersList[index].imageUrl,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: h * 0.05,
                                  width: w * 0.4,
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.7),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(w * 0.04),
                                    ),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      fit: BoxFit.fitWidth,
                                      child: Text(
                                        developersList[index]
                                            .name, // the names of the users are to be entered here in the child
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      child: const Icon(
                                        FontAwesomeIcons.linkedin,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        _launchUniversalLinkApp(
                                          Uri.parse(
                                            developersList[index].linkedInId,
                                          ),
                                        );
                                      },
                                    ),
                                    InkWell(
                                      child: const Icon(
                                        Icons.mail,
                                        color: Colors.white,
                                      ),
                                      onTap: () async {
                                        String email = Uri.encodeComponent(
                                          developersList[index].emailId,
                                        );
                                        String subject = Uri.encodeComponent(
                                            "Hello Flutter");
                                        String body = Uri.encodeComponent(
                                          "Hi! I'm Flutter Developer",
                                        );
                                        Uri mail = Uri.parse(
                                          "mailto:$email?subject=$subject&body=$body",
                                        );
                                        launchUrl(mail);
                                      },
                                    ),
                                    InkWell(
                                      child: const Icon(
                                        FontAwesomeIcons.github,
                                        color: Colors.white,
                                      ),
                                      onTap: () {
                                        _launchUniversalLinkApp(
                                          Uri.parse(
                                            developersList[index].gitHubId,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
