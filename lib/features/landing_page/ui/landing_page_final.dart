import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/features/landing_page/cubit/event_details_cubit_cubit.dart';
import '../logic/event.dart';
import 'custom_appbar.dart';
import 'event_gridview.dart';

class LandingPageContent extends StatefulWidget {
  const LandingPageContent({super.key});

  @override
  State<LandingPageContent> createState() => _LandingPageContentState();
}

class _LandingPageContentState extends State<LandingPageContent> with TickerProviderStateMixin {
  late final TabController tabBarController = TabController(length: 2, vsync: this);
  int page = 2;
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
    if(state is EventDetailsCubitLoaded){
    return Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTitle(fontSizeFactor: fontSizeFactor),
            DefaultTabController(
              length: 2,
              child: TabBar(
                //labelPadding: const EdgeInsets.all(10),
                controller: tabBarController,
                indicator: const BoxDecoration(color: Colors.transparent),
                labelColor: Colors.white,
                unselectedLabelColor: const Color.fromARGB(255, 125, 100, 158),
                tabs: [
                  EventType(eventType: "Tech Events", fontSizeFactor: fontSizeFactor),
                  EventType(eventType: "Non-Tech Events", fontSizeFactor: fontSizeFactor),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                physics: const BouncingScrollPhysics(),
                controller: tabBarController,
                children: [
                  EventGridView(state.events.events!.where((element) => element.type=="Technical").toList()),
                  EventGridView(state.events.events!.where((element) => element.type=="Non Technical").toList()),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: CurvedNavigationBar(
          index: 2,
          height: MediaQuery.of(context).size.height * 0.07,
          items: const <Widget>[
            Icon(Icons.add, size: 30),
            Icon(Icons.list, size: 30),
            Icon(Icons.compare_arrows, size: 30),
            Icon(Icons.call_split, size: 30),
            Icon(Icons.perm_identity, size: 30),
          ],
          color: Colors.white,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 400),
          onTap: (index) {
            setState(() {
              page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
      );}
    return Text("data");
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
        fontSize: fontSizeFactor*8,
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
    return Padding(
      padding: EdgeInsets.only(top: 0.0),
      child: Text(
        "Pulzion '23",
        style: TextStyle(
          fontSize: fontSizeFactor*25,
          color: Colors.white,
        ),
      ),
    );
  }
}
