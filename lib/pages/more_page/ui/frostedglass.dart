import 'dart:ui';

import 'package:flutter/material.dart';
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

  Widget frostedItem(Widget w) {
    return Padding(
      padding: EdgeInsets.all(cheight / 7),
      child: ClipRRect(
        child: Material(
          color: Colors.transparent,
          child: Container(
            height: cheight,
            width: cwidth,
            color: Colors.transparent,
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 4.5, sigmaY: 4.5),
                  child: Container(),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(cheight / 3),
                    border: Border.all(color: Colors.white.withOpacity(0.1)),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.black.withOpacity(0.23),
                        Colors.black.withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: w,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(cheight / 10),
      margin: EdgeInsets.all(cheight / 9),
      height: cheight * childWid.length * 1.15,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cheight / 4),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.black.withOpacity(0.15),
          ],
        ),
      ),
      child: AnimationLimiter(
        child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: childWid.length,
          itemBuilder: (context, index) => AnimationConfiguration.staggeredList(
            position: index,
            duration: const Duration(milliseconds: 1200),
            child: ScaleAnimation(
              child: InkWell(
                onTap: childWid[index].url != null
                    ? () async {
                        await _launchInBrowser(Uri.parse(childWid[index].url!));
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
                        padding: EdgeInsets.all(cheight / 6),
                        child: childWid[index],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: cheight / 15,
                        right: cheight / 15,
                      ),
                      child: const Divider(
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
