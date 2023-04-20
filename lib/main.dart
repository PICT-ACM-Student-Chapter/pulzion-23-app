import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:pulzion23/features/event_slots/logic/booked_slot_cubit.dart';
import 'package:pulzion23/features/registered_events_and_orders/cubit/registered_events_and_orders_cubit.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';

import 'config/remote_config.dart';
import 'constants/images.dart';
import 'constants/utils/theme.dart';
import 'features/cart_page/cubit/cart_page_cubit.dart';
import 'features/compulsory_update/cubit/compulsory_update_cubit.dart';
import 'features/compulsory_update/ui/compulsary_update.dart';
import 'features/home_page/logic/event_details_cubit_cubit.dart';
import 'features/login_page/cubit/check_login_cubit.dart';
import 'firebase_options.dart';
import 'project/cubit/bottom_bar_cubit.dart';
import 'project/landing_page.dart';
import 'services/bloc_observer.dart';
import 'services/firebase_notifications.dart';
import 'services/local_notifications.dart';
// import 'features/event_slots/logic/booked_slot_cubit.dart';
// import 'constants/models/event_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

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
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await Firebase.initializeApp();
  await FirebaseNotifications.initialize();

  log("Starting app");
  if (kDebugMode) {
    Bloc.observer = PulzionBlocObserver();
  }

  runApp(const Pulzion23App());
}

class Pulzion23App extends StatelessWidget {
  const Pulzion23App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CheckLoginCubit()..checkLogin(),
        ),
        BlocProvider(
          create: (context) => CompulsoryUpdateCubit()..needsUpdate(),
        ),
        BlocProvider(
          create: (context) => CartPageCubit(),
        ),
        BlocProvider(
          create: (context) => GlobalParameterCubit(),
        ),
        BlocProvider(
          create: (context) => EventSlotsCubit(),
        )
      ],
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
            // BlocProvider(
            //   create: (context) =>
            //       RegisteredEventsAndOrdersCubit()..getOrders(),
            // ),
          ],
          child: BlocBuilder<CompulsoryUpdateCubit, CompulsoryUpdateState>(
            builder: (context, state) {
              if (state is CompulsoryUpdateLoading) {
                return Scaffold(
                  body: Center(
                    child:
                        Center(child: Lottie.asset(AppImages.loadingAnimation)),
                  ),
                );
              } else if (state is CompulsoryUpdateNeeded) {
                return const CompulsoryUpdatePage();
              } else if (state is CompulsoryUpdateNotNeeded) {
                return const BottomNavBar();
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text('Error'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
