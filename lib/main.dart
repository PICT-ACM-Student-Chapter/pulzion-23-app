import 'package:flutter/material.dart';
import 'package:pulzion23/constants/utils/theme.dart';
import 'package:pulzion23/features/landing_page/ui/event_content.dart';
import 'package:pulzion23/project/routes/app_route_config.dart';

import 'features/landing_page/ui/custom_appbar.dart';
import 'features/landing_page/ui/navigation_drawer.dart';

void main() {
  runApp(const Pulzion23App());
}

class Pulzion23App extends StatelessWidget {
  const Pulzion23App({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp.router(
    //   title: 'Pulzion 23',
    //   theme: Themes.darkTheme,
    //   debugShowCheckedModeBanner: false,
    //   routerConfig: router,
    // );
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: NavigationDrawer(),
        appBar: CustomAppBar(),
        backgroundColor: Color.fromRGBO(49, 19, 91, 1),
        body: LandingPage(),
      ),
    );
  }
}
