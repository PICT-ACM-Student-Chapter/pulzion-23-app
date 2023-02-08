import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../logic/event.dart';
import 'custom_appbar.dart';
import 'event_gridview.dart';
import 'navigation_drawer.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: const CustomAppBar(),
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                "Pulzion '23",
                style: TextStyle(
                  fontSize: 55,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "$page",
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            DefaultTabController(
              length: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: TabBar(
                  labelPadding: const EdgeInsets.all(10),
                  controller: tabBarController,
                  indicator: const BoxDecoration(color: Colors.transparent),
                  labelColor: Colors.white,
                  unselectedLabelColor: const Color.fromARGB(255, 125, 100, 158),
                  tabs: const [
                    Text(
                      'Tech Events',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'Non-Tech Events',
                      style: TextStyle(
                        fontSize: 16,
                      ),
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
                  EventGridView(techEvents),
                  EventGridView(techEvents),
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
      ),
    );
  }
}
