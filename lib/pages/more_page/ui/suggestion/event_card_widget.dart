import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:pulzion23/features/event_description/ui/widgets/lightOnOff.dart';

import '../../../../config/size_config.dart';
import '../../../../constants/models/event_model.dart';
import '../../../../constants/styles.dart';

class EventCard extends StatelessWidget {
  final Events event;
  final List<Events> eventsList;

  const EventCard({
    required this.eventsList,
    required this.event,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final cacheManager = CacheManager(Config(
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
            settings: RouteSettings(
              arguments: eventsList,
            ),
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
                  image: AssetImage('assets/images/manu_frame.png'),
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
                  top: SizeConfig.getProportionateScreenHeight(80),
                  left: SizeConfig.getProportionateScreenWidth(10),
                  right: SizeConfig.getProportionateScreenWidth(10),
                  bottom: SizeConfig.getProportionateScreenHeight(30),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name!,
                      style: AppStyles.NormalText().copyWith(
                          color: Colors.black, fontSize: height * 0.03),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      // Note: This is issue in flutter -> https://github.com/flutter/flutter/issues/98975
                      strutStyle: StrutStyle(
                        height: 1.2,
                        fontSize: SizeConfig.getProportionateScreenFontSize(15),
                        fontWeight: FontWeight.w600,
                        // fontFamily: 'Panther',
                      ),
                    ),
                    Text(
                      event.description!,
                      style: AppStyles.NormalText().copyWith(
                          color: Colors.black, fontSize: height * 0.012),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
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
            child: Padding(
              padding: const EdgeInsets.only(left: 0, top: 10),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: 81,
                    top: 7,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(radius: 1, colors: [
                          Colors.orange[600]!,
                          Colors.black,
                        ]),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black,
                            spreadRadius: 1,
                            blurRadius: 2,
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
                          child:
                              // FlutterLogo()
                              CachedNetworkImage(
                            imageUrl: event.logo!,
                            color: Colors.white,
                            placeholder: (context, url) => Container(),
                            errorWidget: (context, url, error) => Container(),
                            cacheManager: cacheManager,
                            fadeInDuration: const Duration(milliseconds: 100),
                            fit: BoxFit.fitWidth,
                            key: UniqueKey(),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: -10,
                    child: Transform.translate(
                      offset: Offset(
                        -width / 16,
                        width / 60,
                      ),
                      child: SizedBox(
                        // black color container circular with boxshadow
                        width: width / 3.18,
                        height: width / 3.18,
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
