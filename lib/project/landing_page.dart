import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';

import '../config/size_config.dart';
import '../constants/images.dart';
import '../features/cart_page/cubit/cart_page_cubit.dart';
import '../features/cart_page/ui/cart_page_final.dart';
import '../features/home_page/ui/home_page_final.dart';
import '../features/home_page/ui/wigets/custom_appbar.dart';
import '../features/login_page/cubit/check_login_cubit.dart';
import '../features/login_page/ui/login_signup_intro.dart';
import '../pages/about_us_page/ui/about_us.dart';
import '../pages/more_page/ui/more_main.dart';
import 'cubit/bottom_bar_cubit.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Initilize the size config for responsive UI
    SizeConfig.init(context);

    return Stack(
      children: [
        Panorama(
          sensitivity: 0.4,
          animSpeed: 0.5,
          sensorControl: SensorControl.Orientation,
          child: Image.asset(AppImages.spaceBackground, fit: BoxFit.cover),
        ),
        Scaffold(
          appBar: const CustomAppBar(),
          backgroundColor: Colors.transparent,
          body: BlocBuilder<CheckLoginCubit, CheckLoginState>(
            builder: (context, loginState) {
              return BlocBuilder<BottomBarCubit, BottomBarState>(
                builder: (context, state) {
                  if (state is BottomBarAboutUs) {
                    return const AboutUsPage();
                  } else if (state is BottomBarRegisteredEvents) {
                    return loginState is CheckLoginSuccess
                        ? const Center(
                            child: Text(
                              "Registered Events",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        : const LoginSignUpIntro();
                  } else if (state is BottomBarHome) {
                    return const HomePageContent();
                  } else if (state is BottomBarCart) {
                    return Center(
                     child: MultiBlocProvider(
                        providers: [
                          BlocProvider(
                            create: (context) => CartPageCubit()..loadCart(),
                          ),
                          BlocProvider.value(
                           value: BlocProvider.of<CheckLoginCubit>(context),
                          ),
                        ],
                        child: const CartPageFinal(),
                      ),
                    );
                  } else {
                    return const FrostedGlassTile();
                  }
                },
              );
            },
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: CurvedNavigationBar(
              index: 1,
              // Make it 1 for the final version
              height: MediaQuery.of(context).size.height * 0.07,
              items: <Widget>[
                Icon(
                  Icons.info,
                  size: 30,
                  color: Colors.white.withOpacity(0.7),
                ),
                // Icon(
                //   Icons.calendar_month,
                //   size: 30,
                //   color: Colors.white.withOpacity(0.7),
                // ),
                Icon(
                  Icons.home_rounded,
                  size: 30,
                  color: Colors.white.withOpacity(0.7),
                ),
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Colors.white.withOpacity(0.7),
                ),
                Icon(
                  Icons.more_horiz_rounded,
                  size: 30,
                  color: Colors.white.withOpacity(0.7),
                ),
              ],
              color: Colors.grey.withOpacity(0.2),
              buttonBackgroundColor: Colors.white.withOpacity(0.6),
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
