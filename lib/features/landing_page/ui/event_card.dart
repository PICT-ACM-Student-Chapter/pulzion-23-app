import 'package:flutter/material.dart';
import 'package:pulzion23/constants/colors.dart';

import '../../../constants/styles.dart';
import '../logic/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  const EventCard(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Transform.translate(
          offset: Offset(0, MediaQuery.of(context).size.width / 10),
          child: Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.width / 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  event.startColor,
                  event.endColor,
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery.of(context).size.width / 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 12,
                  ),
                  Text(
                    event.title,
                    style: AppStyles.bodyTextStyle2(),
                  ),
                  Text(
                    event.description,
                    style: AppStyles.bodyTextStyle3(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  ),
                  InkWell(
                    onTap: (() {}),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Know More',
                          style: AppStyles.bodyTextStyle4(),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: AppColors.cardTitleTextColor,
                          size: MediaQuery.of(context).size.height / 60,
                        ),
                      ],
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
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  blurRadius: MediaQuery.of(context).size.width / 128,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width / 8,
              backgroundImage: AssetImage(event.imageAddress),
            ),
          ),
        ),
      ],
    );
  }
}
