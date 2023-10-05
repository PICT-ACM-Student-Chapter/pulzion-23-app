import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pulzion23/features/event_description/ui/widgets/lightOnOff.dart';

import '../../../../config/size_config.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/images.dart';
import '../../../../constants/models/event_model.dart';
import '../../../../constants/styles.dart';
import '../../../event_description/ui/event_description.dart';

class EventCard extends StatelessWidget {
  final Events event;

  const EventCard(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    const l = [
      Color.fromARGB(255, 208, 168, 116),
      Color.fromARGB(255, 168, 104, 20),
    ];
    final _cacheManager = CacheManager(Config(
      'my_custom_cache_key',
      stalePeriod: const Duration(days: 7),
      maxNrOfCacheObjects: 100,
    ));

    return InkWell(
      onTap: (() {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DarkSample(event: event),
          ),
        );
      }),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Transform.translate(
            offset: Offset(
              0,
              SizeConfig.getProportionateScreenHeight(43),
            ),
            child: Container(
              height: 700,
              width: SizeConfig.getProportionateScreenWidth(300),
              padding: EdgeInsets.only(
                top: SizeConfig.getProportionateScreenHeight(10),
                left: SizeConfig.getProportionateScreenWidth(10),
                right: SizeConfig.getProportionateScreenWidth(10),
                bottom: SizeConfig.getProportionateScreenHeight(10),
              ),
              margin: EdgeInsets.only(
                bottom: SizeConfig.getProportionateScreenWidth(53),
              ),
              decoration: BoxDecoration(
                // color: Colors.black,
                image: const DecorationImage(
                  image: AssetImage('assets/images/manuscript.png'),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(
                //   color: Colors.white,
                //   width: 0.2,
                // ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.getProportionateScreenHeight(100),
                  left: SizeConfig.getProportionateScreenWidth(10),
                  right: SizeConfig.getProportionateScreenWidth(10),
                  bottom: SizeConfig.getProportionateScreenHeight(40),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name!,
                      style: AppStyles.NormalText().copyWith(
                          color: Colors.black, fontSize: width * 0.075),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      // Note: This is issue in flutter -> https://github.com/flutter/flutter/issues/98975
                      strutStyle: StrutStyle(
                        height: 1.2,
                        fontSize: SizeConfig.getProportionateScreenFontSize(15),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Gothica-Book',
                      ),
                    ),
                    Text(
                      event.description!,
                      style: AppStyles.NormalText().copyWith(
                          color: Colors.black, fontSize: width * 0.02),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Transform.translate(
          //     offset: Offset(width / 11, height / 30),
          //     child: Image.asset(
          //       AppImages.cobweb,
          //       width: width / 2.5,
          //       height: width / 2.5,
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.topLeft,
            child: Hero(
              tag: 'event${event.id}',
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 10),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: 76,
                      top: 13,
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(radius: 1, colors: l),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromARGB(255, 232, 230, 230),
                              spreadRadius: 0,
                              blurRadius: 5,
                            ),
                          ],
                        ),
                        width: width / 3.9,
                        height: width / 3.9,
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: SizeConfig.getProportionateScreenWidth(15),
                            right: SizeConfig.getProportionateScreenWidth(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 17,
                              right: 12,
                              top: 10,
                              bottom: 17,
                            ),
                            child: CachedNetworkImage(
                              imageUrl: event.logo!,
                              color: Colors.white,
                              placeholder: (context, url) => Container(),
                              errorWidget: (context, url, error) => Container(),
                              cacheManager: _cacheManager,
                              fadeInDuration: const Duration(milliseconds: 100),
                              fit: BoxFit.fitWidth,
                              key: UniqueKey(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 15,
                      top: -10,
                      child: Transform.translate(
                        offset: Offset(
                          -width / 16,
                          width / 60,
                        ),
                        child: SizedBox(
                          // black color container circular with boxshadow
                          width: width / 3.1,
                          height: width / 3.1,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Image.asset(
                              'assets/images/ringneww.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0.9, -0.65),
            child: Padding(
              padding: EdgeInsets.only(
                top: SizeConfig.getProportionateScreenHeight(10),
                right: SizeConfig.getProportionateScreenWidth(10),
              ),
              child: Icon(
                event.mode == 'Online'
                    ? Icons.laptop
                    : Icons.location_on_outlined,
                color: const Color.fromRGBO(165, 42, 42, 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
