import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../constants/styles.dart';
import '../../../features/home_page/ui/wigets/custom_appbar.dart';
import 'package:widget_circular_animator/widget_circular_animator.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:panorama/panorama.dart';
import 'info.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants/images.dart';
import '../../../project/cubit/animation_toggle_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'dart:math' as math;

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
  final _cacheManager = CacheManager(Config(
    'my_custom_cache_key',
    stalePeriod: const Duration(days: 7),
    maxNrOfCacheObjects: 100,
  ));

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
            return Image.asset(AppImages.spaceBackground2, fit: BoxFit.cover);
          },
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: const CustomAppBar(),
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      Positioned(
                        top: h / 20,
                        child: Center(
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
                                shape: BoxShape.rectangle,
                                gradient: RadialGradient(
                                  center: const Alignment(-0.8, -0.6),
                                  colors: const [
                                    Color.fromRGBO(9, 7, 130, 1),
                                    Color.fromRGBO(160, 11, 143, 0.91),
                                    Colors.purple,
                                  ],
                                  radius: w * 0.016,
                                ),
                                borderRadius: BorderRadius.circular(30),
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
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.rotationY(math.pi),
                            child: SizedBox(
                              height: h / 8,
                              child: Lottie.asset(AppImages.errorSpaceman),
                            ),
                          ),
                          SizedBox(
                            height: h / 8,
                            child: Lottie.asset(AppImages.errorSpaceman),
                          ),
                        ],
                      ),
                    ],
                  ),
// SizedBox(height: h/5,
//   width: w*0.5,),

                  Row(
                    children: [
                      SizedBox(
                        height: h * 0.1,
                        width: w * 0.24,
                        child: Lottie.asset(AppImages.errorSpaceman),
                      ),
                      SizedBox(
                        height: h * 0.1,
                        width: w * 0.23,
                        child: Lottie.asset(AppImages.errorSpaceman),
                      ),
                      SizedBox(
                        height: h * 0.1,
                        width: w * 0.24,
                        child: Lottie.asset(AppImages.errorSpaceman),
                      ),
                      SizedBox(
                        height: h * 0.1,
                        width: w * 0.23,
                        child: Lottie.asset(AppImages.errorSpaceman),
                      ),
                    ],
                  ),
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent:
                            MediaQuery.of(context).orientation ==
                                    Orientation.landscape
                                ? w * 0.25
                                : w * 0.5,
                        childAspectRatio: 1 / h * 500,
                        crossAxisSpacing: h * 0.015,
                        mainAxisSpacing: h * 0.015,
                      ),
                      itemCount: developersList.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            gradient: RadialGradient(
                              center: const Alignment(-0.8, -0.6),
                              colors: [
                                Colors.purple.withOpacity(0.1),
                                Colors.purple.withOpacity(0),
                              ],
                              radius: w * 0.016,
                            ),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.orange,
                              width: 0.5,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    // image: const DecorationImage(
                                    //   image: AssetImage(
                                    //     "assets/images/frame-3.png",
                                    //   ),
                                    //   fit: BoxFit.cover,
                                    // ),
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                      color: Colors.transparent,
                                      width: 0.5,
                                    ),
                                  ),
                                  padding: EdgeInsets.all(h * 0.005),
                                  alignment: Alignment.topCenter,
                                  height: h * 0.252,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      padding: const EdgeInsets.all(1),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                          color: Colors.black,
                                          width: 1.5,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(7),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              developersList[index].imageUrl,
                                          placeholder: (context, url) =>
                                              Image.asset(
                                            'assets/images/placeholder_person.png',
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(),
                                          cacheManager: _cacheManager,
                                          fadeInDuration:
                                              const Duration(milliseconds: 100),
                                          fit: BoxFit.fitWidth,
                                          key: UniqueKey(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 0),
                                  child: Container(
                                    height: h * 0.04,
                                    width: w * 0.4,
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
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: Colors.orange[500]!
                                            .withOpacity(0.8),
                                        width: 0.7,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 1.0,
                                          spreadRadius: 1.0,
                                          color: Colors.purple[600]!
                                              .withOpacity(0.3),
                                        ),
                                      ],

                                      // boxShadow: [
                                      //   BoxShadow(
                                      //     color: Colors.yellow.withOpacity(0.5),
                                      //     spreadRadius: 1,
                                      //     blurRadius: 1,
                                      //   ),
                                      // ],
                                      // border: Border.all(
                                      //   color: Colors.orange,
                                      //   width: 0.5,
                                      // ),

                                      // image: const DecorationImage(
                                      //   image: AssetImage(
                                      //     "assets/images/nameplate1.jpg",
                                      //   ),
                                      //   fit: BoxFit.cover,
                                      // ),
                                      // borderRadius: BorderRadius.circular(20),
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
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        child: const Icon(
                                          FontAwesomeIcons.linkedin,
                                          color:
                                              Color.fromARGB(255, 196, 95, 13),
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
                                          color:
                                              Color.fromARGB(255, 196, 95, 13),
                                        ),
                                        onTap: () async {
                                          String email = Uri.encodeComponent(
                                            developersList[index].emailId,
                                          );
                                          String subject = Uri.encodeComponent(
                                            "",
                                          );
                                          String body = Uri.encodeComponent(
                                            "",
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
                                          color:
                                              Color.fromARGB(255, 196, 95, 13),
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
