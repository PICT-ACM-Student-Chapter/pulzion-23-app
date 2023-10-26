import 'dart:developer';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/urls.dart';
import 'package:pulzion23/features/mcq/features/mcq_login/ui/mcq_login.dart';
import '../config/size_config.dart';
import '../features/cart_page/cubit/cart_page_cubit.dart';
import '../features/cart_page/ui/cart_page_final.dart';
import '../features/home_page/ui/home_page_final.dart';
import '../features/home_page/ui/wigets/custom_appbar.dart';
import '../features/login_page/cubit/check_login_cubit.dart';
import '../features/login_page/ui/login_signup_intro.dart';
import '../features/registered_events_and_orders/ui/registered_events_and_orders.dart';
import '../pages/about_us_page/ui/about_us.dart';
import '../pages/more_page/ui/more_main.dart';
import 'cubit/bottom_bar_cubit.dart';
import 'cubit/animation_toggle_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Initilize the size config for responsive UI
    SizeConfig.init(context);

    return Stack(
      children: [
        BlocConsumer<GlobalParameterCubit, bool>(
          listener: (context, state) {},
          buildWhen: (previous, current) {
            if (previous != current) {
              return true;
            }

            return false;
          },
          builder: (context, state) {
            return Container(
              constraints: const BoxConstraints.expand(),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/app_background.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: const CustomAppBar(),
          backgroundColor: Colors.transparent,
          body: BlocBuilder<CheckLoginCubit, CheckLoginState>(
            builder: (context, loginState) {
              return BlocBuilder<BottomBarCubit, BottomBarState>(
                builder: (context, state) {
                  log(EndPoints.mcqStarted.toString());
                  if (state is BottomBarAboutUs) {
                    return EndPoints.mcqStarted == true
                        ? const MCQLogin()
                        : AboutUsPage(false);
                  } else if (state is BottomBarRegisteredEvents) {
                    return loginState is CheckLoginSuccess
                        ? const RegisteredEventsAndOrders()
                        : const LoginSignupBody();
                  } else if (state is BottomBarHome) {
                    return const HomePageContent();
                  } else if (state is BottomBarCart) {
                    BlocProvider.of<CartPageCubit>(context).loadCart();

                    return loginState is CheckLoginSuccess
                        ? const Center(
                            child: CartPageFinal(),
                          )
                        : const LoginSignupBody();
                  } else {
                    return const FrostedGlassTile();
                  }
                },
              );
            },
          ),
          bottomNavigationBar: Container(
            margin:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: CurvedNavigationBar(
              index: 2,
              height: MediaQuery.of(context).size.height * 0.07,
              items: <Widget>[
                Icon(
                  EndPoints.mcqStarted == true
                      ? Icons.mobile_screen_share
                      : Icons.info,
                  size: 30,
                  color: const Color.fromARGB(255, 228, 188, 136),
                ),
                const Icon(
                  Icons.calendar_month,
                  size: 30,
                  color: Color.fromARGB(255, 228, 188, 136),
                ),
                const Icon(
                  Icons.home_rounded,
                  size: 30,
                  color: Color.fromARGB(255, 228, 188, 136),
                ),
                const Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Color.fromARGB(255, 228, 188, 136),
                ),
                const Icon(
                  Icons.more_horiz_rounded,
                  size: 30,
                  color: Color.fromARGB(255, 228, 188, 136),
                ),
              ],
              color: Colors.grey.withOpacity(0.2),
              buttonBackgroundColor: const Color.fromARGB(255, 122, 73, 9),
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 400),
              onTap: (index) {
                context.read<BottomBarCubit>().changeIndexVersion1(index);
              },
              letIndexChange: (index) => true,
            ),
          ),
        ),
      ],
    );
  }
}
