import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:url_launcher/url_launcher.dart';

import 'child_wild.dart';

class FrostedGlassBox extends StatelessWidget {
  final double cwidth, cheight;
  final List<FrostedTile> childWid;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  const FrostedGlassBox({
    super.key,
    required this.cheight,
    required this.cwidth,
    required this.childWid,
  });

  // Widget frostedItem(Widget w) {
  //   return Padding(
  //     padding: EdgeInsets.all(cheight / 7),
  //     child: ClipRRect(
  //       child: Material(
  //         color: Colors.transparent,
  //         child: Container(
  //           height: cheight,
  //           width: cwidth,
  //           color: Colors.transparent,
  //           child: Stack(
  //             children: [
  //               BackdropFilter(
  //                 filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
  //                 child: Container(),
  //               ),
  //               Container(
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.circular(cheight / 3),
  //                   border: Border.all(color: Colors.white.withOpacity(0.1)),
  //                   gradient: LinearGradient(
  //                     begin: Alignment.topLeft,
  //                     end: Alignment.bottomRight,
  //                     colors: [
  //                       Colors.black.withOpacity(0.23),
  //                       Colors.black.withOpacity(0.05),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               Center(
  //                 child: w,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: ClipPath(
        clipper: MovieTicketBothSidesClipper(),
        child: Container(
          padding: EdgeInsets.all(cheight / 10),
          // margin: EdgeInsets.only(
          //   bottom: cheight / 4,
          // ),
          height: cheight * childWid.length * 1.1,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/event_frame.png'),
              fit: BoxFit.fill, // Adjust this based on your needs
            ),
          ),
          child: AnimationLimiter(
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: childWid.length,
              itemBuilder: (context, index) =>
                  AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 1200),
                child: ScaleAnimation(
                  child: InkWell(
                    onTap: childWid[index].url != null
                        ? () async {
                            await _launchInBrowser(
                              Uri.parse(childWid[index].url!),
                            );
                          }
                        : childWid[index].onTap ??
                            () {
                              // If Both URL and onTap are not present then do nothing
                              null;
                            },
                    child: Column(
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: Padding(
                            padding: EdgeInsets.all(
                              cheight / 6,
                            ),
                            child: childWid[index],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: cheight / 15,
                            right: cheight / 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
