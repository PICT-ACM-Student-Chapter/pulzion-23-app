import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../logic/event.dart';
import 'event_gridview.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  late final TabController tabBarController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // const Padding(
        //   padding: EdgeInsets.only(top: 8.0),
        //   child: Text(
        //     "Pulzion '23",
        //     style: TextStyle(
        //       fontSize: 55,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
        // const Padding(
        //   padding: EdgeInsets.only(top: 8.0, bottom: 20),
        //   child: Text(
        //     "An annual tech fest of PICT ACM Student Chapter",
        //     style: TextStyle(
        //       fontSize: 16,
        //       color: Colors.white,
        //     ),
        //   ),
        // ),
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
            controller: tabBarController,
            children: [
              EventGridView(techEvents),
              EventGridView(nonTechEvents),
            ],
          ),
        ),
      ],
    );
  }
}
