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
              margin: EdgeInsets.only(
                bottom: SizeConfig.getProportionateScreenWidth(53),
              ),
              decoration: BoxDecoration(
                image: const DecorationImage(
                    image: AssetImage(AppImages.manuscript), fit: BoxFit.fill),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.white,
                  width: 0.2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: SizeConfig.getProportionateScreenHeight(80),
                  left: SizeConfig.getProportionateScreenWidth(10),
                  right: SizeConfig.getProportionateScreenWidth(10),
                  bottom: SizeConfig.getProportionateScreenHeight(20),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name!,
                      style: AppStyles.bodyTextStyle2().copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      // Note: This is issue in flutter -> https://github.com/flutter/flutter/issues/98975
                      strutStyle: StrutStyle(
                        height: 1.2,
                        fontSize: SizeConfig.getProportionateScreenFontSize(15),
                        fontWeight: FontWeight.w600,
                        fontFamily: 'Panther',
                      ),
                    ),
                    Text(
                      event.description!,
                      style: AppStyles.bodyTextStyle3().copyWith(color: Colors.black),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Transform.translate(
              offset: Offset(width / 11, height / 30),
              child: Image.asset(
                AppImages.cobweb,
                width: width / 2.5,
                height: width / 2.5,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Hero(
              tag: 'event${event.id}',
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Transform.translate(
                    offset: Offset(
                      -width / 8.7,
                      -width / 8,
                    ),
                    child: Image.asset(
                      AppImages.seal,
                      width: width / 2,
                      height: width / 2,
                    ),
                  ),
                  Container(
                    width: width / 4,
                    height: width / 4,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.transparent,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(
                        SizeConfig.getProportionateScreenWidth(15),
                      ),
                      child: CachedNetworkImage(
                        imageUrl: event.logo!,
                        placeholder: (context, url) => Container(),
                        errorWidget: (context, url, error) => Container(),
                        cacheManager: _cacheManager,
                        fadeInDuration: const Duration(milliseconds: 100),
                        fit: BoxFit.fitWidth,
                        key: UniqueKey(),
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
                event.mode == 'Online' ? Icons.laptop : Icons.location_on_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
