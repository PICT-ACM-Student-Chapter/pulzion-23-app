import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/home_page/logic/event_details_cubit_cubit.dart';
import '../features/login_page/cubit/check_login_cubit.dart';
import '../project/cubit/bottom_bar_cubit.dart';
import 'package:get_it/get_it.dart';

class BlocInitializer {
  static get getIt => GetIt.instance;

  static void initialize() {
    getIt.registerFactory(() => BottomBarCubit());
    getIt.registerFactory(() => EventDetailsCubitCubit()..getEventsDetails());
    getIt.registerFactory(() => CheckLoginCubit());
  }
}