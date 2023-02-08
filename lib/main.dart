import 'package:flutter/material.dart';
import 'package:pulzion23/config/remote_config.dart';
// import 'package:pulzion23/constants/models/user_model.dart';
// import 'package:pulzion23/constants/urls.dart';
import 'package:pulzion23/constants/utils/theme.dart';
import 'package:pulzion23/features/landing_page/ui/landing_page_content.dart';
import 'package:pulzion23/project/routes/app_route_config.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'features/landing_page/ui/custom_appbar.dart';
import 'features/landing_page/ui/navigation_drawer.dart';
import 'package:firebase_core/firebase_core.dart';

// import 'constants/models/event_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await remoteConfig();
  // await getEvents();
  // await getUser();
  runApp(const Pulzion23App());
}

class Pulzion23App extends StatelessWidget {
  const Pulzion23App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pulzion 23',
      theme: Themes.darkTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
