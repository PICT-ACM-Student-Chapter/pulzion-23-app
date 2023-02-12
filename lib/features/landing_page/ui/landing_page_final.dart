import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/features/landing_page/cubit/event_details_cubit_cubit.dart';
import '../../../constants/colors.dart';
import '../../../constants/images.dart';
import '../logic/event.dart';
import 'custom_appbar.dart';
import 'event_gridview.dart';
import 'navigation_bar.dart';

class LandingPageContent extends StatefulWidget {
  const LandingPageContent({super.key});

  @override
  State<LandingPageContent> createState() => _LandingPageContentState();
}

class _LandingPageContentState extends State<LandingPageContent> with TickerProviderStateMixin {
  late final TabController tabBarController = TabController(length: 2, vsync: this);
  int page = 2;
  final SensorControl sensorControl = SensorControl.AbsoluteOrientation;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;
    final height = mediaQuery.size.height;
    final fontSizeFactor = height / width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => EventDetailsCubitCubit()..getEventsDetails(),
        child: BlocBuilder<EventDetailsCubitCubit, EventDetailsCubitState>(
          builder: (context, state) {
            if (state is EventDetailsCubitLoaded) {
              return Stack(
                children: [
                  Panorama(
                    sensitivity: 0.4,
                    animSpeed: 0.5,
                    sensorControl: SensorControl.Orientation,
                    child: Image.asset(AppImages.spaceBackground, fit: BoxFit.cover),
                  ),
                  Sizer(
                    builder: ((context, orientation, deviceType) {
                      return Scaffold(
                        appBar: const CustomAppBar(),
                        backgroundColor: Colors.transparent,
                        body: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppTitle(fontSizeFactor: fontSizeFactor),
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
                                  tabs: [
                                    EventType(
                                        eventType: "Tech Events", fontSizeFactor: fontSizeFactor),
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
                        ),
                        bottomNavigationBar: const CustomBottomNavigationBar(),
                      );
                    }),
                  ),
                ],
              );
            } else if (state is EventDetailsCubitLoading) {
              return Center(child: Lottie.asset(AppImages.loadingAnimation));
            } else {
              return const Center(child: Text("Something went wrong"));
            }
          },
        ),
      ),
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

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    required this.fontSizeFactor,
  });

  final double fontSizeFactor;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -20.h,
          left: 43.w,
          child: Lottie.asset(
            AppImages.ufo,
            height: 300,
            width: 300,
          ),
        ),
        Center(
          child: Text(
            "Pulzion '23",
            style: AppStyles.bodyTextStyle2().copyWith(fontSize: 45),
          ),
        ),
      ],
    );
  }
}
