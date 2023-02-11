import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pulzion23/constants/colors.dart';
import 'package:pulzion23/constants/models/event_model.dart';
import 'package:pulzion23/features/landing_page/ui/home_page.dart';
import '../../../constants/styles.dart';
import '../logic/event.dart';

class EventCard extends StatelessWidget {
  final Events event;
  const EventCard(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final fontSizeFactor = height / width;
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
                  const Color(0xffebf4f5),
                  const Color.fromARGB(255, 87, 95, 107),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical:MediaQuery.of(context).size.width / 10,horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.width / 12,
                  ),
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
                  InkWell(
                    onTap: (() {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage(event: event,)));
                    }),
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
                          size: height / 60,
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
                  blurRadius: 8,
                ),
              ],
            ),
            child: CircleAvatar(
              radius: width / 8,
              //backgroundImage: NetworkImage(event.logo!),
              backgroundImage: AssetImage('assets/images/image1.jpg'),
            ),
          ),
        ),
      ],
    );
  }
}
