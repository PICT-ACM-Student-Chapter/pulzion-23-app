// ignore_for_file: prefer_const_constructors

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pulzion23/features/event_description/ui/event_description.dart';
import 'package:pulzion23/features/login_page/ui/login.dart';
import 'package:pulzion23/features/login_page/ui/login_signup_intro.dart';
import 'package:pulzion23/project/cubit/bottom_bar_cubit.dart';
import 'package:pulzion23/project/routes/app_route_constant.dart';
import '../../features/login_page/ui/sign_up.dart';
import '../../features/profile_page/ui/profile_page.dart';
import '../../features/landing_page/ui/landing_page.dart';

final GoRouter router = GoRouter(routes: [
  // Implement routes for landing and profile pages
  GoRoute(
    path: '/',
    name: RouteName.landing,
    builder: (context, state) => BlocProvider(
      create: (context) => BottomBarCubit(),
      child: LandingPage(),
    ),
  ),
  GoRoute(
    path: '/profile',
    name: RouteName.profile,
    builder: (context, state) => const ProfilePage(),
  ),
  GoRoute(
    path: '/login',
    name: RouteName.login,
    builder: (context, state) => const Login(),
  ),
  GoRoute(
    path: '/signup',
    name: RouteName.signup,
    builder: (context, state) => SignUp(),
  ),
]);
