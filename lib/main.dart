import 'package:flutter/material.dart';
import 'package:pulzion23/constants/utils/theme.dart';
import 'package:pulzion23/project/routes/app_route_config.dart';

void main() {
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
