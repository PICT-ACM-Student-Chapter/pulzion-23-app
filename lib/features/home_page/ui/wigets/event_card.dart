import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
    final fontSizeFactor = height / width;
    return InkWell(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventDescription(
                      event: event,
                    )));
      }),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Transform.translate(
            offset: Offset(0, MediaQuery.of(context).size.width / 10),
            child: Container(
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.width / 8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: AppColors.eventCardGradientList.elementAt(
                    event.id! % AppColors.eventCardGradientList.length,
                  ),
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white,
                  width: 0.2,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.width / 5,
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.name!,
                      style: AppStyles.bodyTextStyle2(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Text(
                      event.description!,
                      style: AppStyles.bodyTextStyle3(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Transform.rotate(
                        angle: pi / 2,
                        child: Lottie.asset(AppImages.rocketButton,
                            height: 50, width: 50),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 8,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: width / 8,
                //backgroundImage: NetworkImage(event.logo!),
                backgroundImage: const AssetImage('assets/images/image1.jpg'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
