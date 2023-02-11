// ignore_for_file: prefer_const_constructors

import 'package:go_router/go_router.dart';
import 'package:pulzion23/features/login_page/ui/login.dart';
import 'package:pulzion23/features/login_page/ui/login_signup_intro.dart';
import 'package:pulzion23/project/routes/app_route_constant.dart';

import '../../features/login_page/ui/sign_up.dart';
import '../../features/profile_page/ui/profile_page.dart';

final GoRouter router = GoRouter(routes: [
  // Implement routes for landing and profile pages
  GoRoute(
    path: '/',
    name: RouteName.landing,
    builder: (context, state) => LoginSignUpIntro(),
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
