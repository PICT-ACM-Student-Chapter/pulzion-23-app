import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/constants/models/event_model.dart';

import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';

class EventDescription extends StatefulWidget {
  final Events? event;
  const EventDescription({this.event, Key? key}) : super(key: key);

  @override
  State<EventDescription> createState() => _EventDescriptionState();
}

class _EventDescriptionState extends State<EventDescription> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final event = widget.event!;
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    int activeIndex = 1;
    late final TabController tabBarController = TabController(length: 3, vsync: this);
    String title = "";
    final fontSizeFactor = h / w;
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: Container(
        margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(color: Colors.black, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.7),
            spreadRadius: 3,
            blurRadius: 9,
            offset: const Offset(0, -4), // changes position of shadow
          ),
        ]),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: h / 12,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "PRICE",
                      style: AppStyles.bodyTextStyle3().copyWith(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Rs. 30",
                          style: AppStyles.bodyTextStyle3(),
                        ),
                        Text(
                          "/person",
                          style: AppStyles.bodyTextStyle3(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                    gradient: const LinearGradient(
                        colors: [Color(0xff07f49e), Color(0xff42047e)],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Add to Cart  ",
                        style: AppStyles.bodyTextStyle3().copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: h / 3,
                    child: Lottie.asset("assets/images/space.json", fit: BoxFit.fill),
                  ),
                  Container(
                    height: h / 2.8,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.deepPurple.withOpacity(0.3), Colors.black],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                      child: InkWell(
                        onTap: (() {
                          Navigator.pop(context);
                        }),
                        child: Transform.rotate(
                          angle: -pi / 2,
                          child: Lottie.asset(AppImages.rocketButton, height: 50, width: 50),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          children: [
                            Image.asset(
                              "assets/images/icon.png",
                              scale: 6,
                            ),
                            Text(
                              event.name!,
                              style: AppStyles.bodyTextStyle2().copyWith(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: DefaultTabController(
                          length: 2,
                          child: TabBar(
                            labelPadding: const EdgeInsets.all(12),
                            controller: tabBarController,
                            indicator: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: AppColors.loginPageAccent,
                                ),
                              ),
                            ),
                            unselectedLabelColor: AppColors.cardSubtitleTextColor,
                            labelColor: AppColors.loginPageAccent,
                            tabs: const [
                              Text("Description",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              Text("Rounds",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                              Text("Rules",
                                  style: TextStyle(
                                      fontFamily: 'Quicksand',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500)),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: h / 1.5,
                        width: w,
                        child: TabBarView(
                          physics: const BouncingScrollPhysics(),
                          controller: tabBarController,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    event.tagline!,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: fontSizeFactor * 8,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFFfafafa),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    event.description!,
                                    style: AppStyles.bodyTextStyle3(),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Team Details :',
                                    style: AppStyles.bodyTextStyle3().copyWith(
                                      color: AppColors.loginPageAccent,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    event.teams!,
                                    style: AppStyles.bodyTextStyle3(),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              event.rounds!,
                              style: AppStyles.bodyTextStyle3(),
                            ),
                            Text(
                              event.rules!,
                              style: AppStyles.bodyTextStyle3(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
