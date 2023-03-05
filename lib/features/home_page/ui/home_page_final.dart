import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../../../constants/styles.dart';
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
    return BlocBuilder<EventDetailsCubitCubit, EventDetailsCubitState>(
      builder: (context, state) {
        if (state is EventDetailsCubitLoaded) {
          return Sizer(
            builder: ((context, orientation, deviceType) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      // ufo position
                      Positioned(
                        top: height * 0.03,
                        left: width * 0.05,
                        width: width - width * 0.37,
                        child: AnimatedAlign(
                          curve: Curves.easeInCubic,
                          duration: const Duration(milliseconds: 1000),
                          alignment: a == 0
                              ? Alignment.centerLeft
                              : Alignment.centerRight,

                          // child: Transform.rotate(
                          //   angle: pi,
                          child: Lottie.asset(AppImages.ufo3,
                              width: 70, height: 70),
                          // )
                        ),
                      ),
                      Center(
                        child: Text(
                          "Pulzion '23",
                          style:
                              AppStyles.bodyTextStyle2().copyWith(fontSize: 45),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        onTap: (_) {
                          changeAnimation(tabBarController.index);
                        },
                        tabs: [
                          EventType(
                              eventType: "Tech Events",
                              fontSizeFactor: fontSizeFactor),
                          EventType(
                              eventType: "Non-Tech Events",
                              fontSizeFactor: fontSizeFactor),
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
                            .where((element) => element.type == "Technical")
                            .toList()),
                        EventGridView(state.events.events!
                            .where((element) => element.type == "Non Technical")
                            .toList()),
                      ],
                    ),
                  ),
                ],
              );
            }),
          );
        } else if (state is EventDetailsCubitLoading) {
          return Center(child: Lottie.asset(AppImages.loadingAnimation));
        } else {
          return const Center(child: Text("Something went wrong"));
        }
      },
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
    return Text(
      eventType,
      style: TextStyle(
        fontSize: fontSizeFactor * 8,
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
