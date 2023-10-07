import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/features/home_page/ui/wigets/animation.dart';
import 'package:sizer/sizer.dart';

import '../../../config/size_config.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
import '../../../constants/widgets/error_dialog.dart';
import '../logic/event_details_cubit_cubit.dart';
import 'wigets/event_gridview.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent>
    with TickerProviderStateMixin {
  late TabController tabBarController;
  int page = 2;
  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;
  int a = 0;

  @override
  void initState() {
    super.initState();
    tabBarController = TabController(length: 2, vsync: this);

    tabBarController.addListener(() {
      setState(() {
        a = tabBarController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    tabBarController.dispose();
  }

  void changeAnimation(int index) {
    setState(() {
      a = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final fontSizeFactor = height / width;

    return Stack(
      children: [
        BlocBuilder<EventDetailsCubitCubit, EventDetailsCubitState>(
          builder: (context, state) {
            if (state is EventDetailsCubitLoaded) {
              return Sizer(
                builder: (context, orientation, deviceType) {
                  return Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                top: height * 0.03,
                                left: width * 0.038,
                                width: width - width * 0.405,
                                child: AnimatedAlign(
                                  curve: Curves.easeInCubic,
                                  duration: const Duration(milliseconds: 1000),
                                  alignment: a == 0
                                      ? Alignment.centerLeft
                                      : Alignment.centerRight,

                                  // child: Transform.rotate(
                                  //   angle: pi,
                                  // child: Lottie.asset(
                                  //   'assets/images/Wh.json',
                                  //   width: width * 0.16,
                                  //   height: height * 0.1,
                                  // ),
                                  // )
                                ),
                              ),
                              Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Pulzion",
                                        style: AppStyles.NormalText().copyWith(
                                          color: const Color.fromARGB(
                                              255, 208, 168, 116),
                                          fontSize: SizeConfig
                                              .getProportionateScreenFontSize(
                                                  height * 0.1),
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(bottom: 5),
                                      //   child: Lottie.asset(
                                      //     'assets/images/pn.json',
                                      //     width: width*0.3,
                                      //     height: width*0.2,
                                      //   ),
                                      // ),
                                      // Text(
                                      //   'n',
                                      //   style: AppStyles.TitleText().copyWith(
                                      //     fontSize:
                                      //         SizeConfig.getProportionateScreenFontSize(
                                      //            height*0.1 ),
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Text(
                                    'Tech or Treat',
                                    style: AppStyles.TitleText().copyWith(
                                      color: const Color.fromARGB(
                                          255, 208, 168, 116),
                                      fontSize: SizeConfig
                                          .getProportionateScreenFontSize(
                                        height * 0.05,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: DefaultTabController(
                              length: 2,
                              child: TabBar(
                                labelPadding: const EdgeInsets.all(12),
                                controller: tabBarController,
                                indicator: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Color.fromARGB(255, 208, 168, 116),
                                    ),
                                  ),
                                ),
                                unselectedLabelColor:
                                    AppColors.cardSubtitleTextColor,
                                labelColor: Colors.orangeAccent,
                                onTap: (_) {
                                  changeAnimation(tabBarController.index);
                                },
                                tabs: [
                                  EventType(
                                    eventType: "Tech Events",
                                    fontSizeFactor: fontSizeFactor,
                                  ),
                                  EventType(
                                    eventType: "Non-Tech Events",
                                    fontSizeFactor: fontSizeFactor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: TabBarView(
                              physics: const BouncingScrollPhysics(),
                              controller: tabBarController,
                              children: [
                                EventGridView(state.events.events!
                                    .where((element) =>
                                        element.type == "Technical")
                                    .toList()),
                                EventGridView(state.events.events!
                                    .where(
                                      (element) =>
                                          element.type == "Non Technical",
                                    )
                                    .toList()),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const TranslateImage(),
                    ],
                  );
                },
              );
            } else if (state is EventDetailsCubitLoading) {
              return Center(child: Lottie.asset(AppImages.loadingAnimation));
            } else {
              return Center(
                child: ErrorDialog(
                  'Error while fetching data from server',
                  refreshFunction: () {
                    log("refreshing");
                    context.read<EventDetailsCubitCubit>().getEventsDetails();
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}

class EventType extends StatelessWidget {
  const EventType({
    super.key,
    required this.eventType,
    required this.fontSizeFactor,
  });

  final String eventType;
  final double fontSizeFactor;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    return Text(
      eventType,
      style: TextStyle(
        fontSize: width * 0.075,
        fontFamily: 'Danger-Night',
      ),
    );
  }
}

// class AppTitle extends StatelessWidget {
//   const AppTitle({
//     super.key,
//     required this.fontSizeFactor,
//   });
//
//   final double fontSizeFactor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       clipBehavior: Clip.none,
//       children: [
//         // ufo position
//         Positioned(
//           top: -10.h,
//           left: ,
//           child: Lottie.asset(
//             AppImages.ufo2,
//             height: 200,
//             width: 100,
//           ),
//         ),
//         Center(
//           child: Text(
//             "Pulzion '23",
//             style: AppStyles.bodyTextStyle2().copyWith(fontSize: 45),
//           ),
//         ),
//       ],
//     );
//   }
// }
