import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/config/remote_config.dart';
import 'package:pulzion23/constants/utils/theme.dart';
import 'package:pulzion23/project/landing_page.dart';
import 'package:pulzion23/firebase_options.dart';
import 'package:pulzion23/project/cubit/bottom_bar_cubit.dart';
import 'package:firebase_core/firebase_core.dart';

import 'features/home_page/logic/event_details_cubit_cubit.dart';
import 'features/login_page/cubit/check_login_cubit.dart';
import 'services/bloc_observer.dart';
import 'services/firebase_notifications.dart';
import 'services/local_notifications.dart';

// import 'constants/models/event_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Color.fromARGB(0, 0, 0, 0),
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // First initialize the remote config
  await remoteConfig();

  // Then initialize the local notification service
  LocalNotificationService.initialize();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FirebaseNotifications.initialize();

  log("Starting app");
  Bloc.observer = PulzionBlocObserver();
  runApp(const Pulzion23App());
}

class Pulzion23App extends StatelessWidget {
  const Pulzion23App({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckLoginCubit()..checkLogin(),
      child: MaterialApp(
        title: 'Pulzion 23',
        theme: Themes.darkTheme,
        debugShowCheckedModeBanner: false,
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (BuildContext context) => BottomBarCubit(),
            ),
            BlocProvider(
              create: (context) => EventDetailsCubitCubit()..getEventsDetails(),
            ),
          ],
          child: const BottomNavBar(),
        ),
      ),
    );
  }
}
