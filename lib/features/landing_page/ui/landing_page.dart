import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:panorama/panorama.dart';
import 'package:pulzion23/features/cart_page/ui/cart_page.dart';
import 'package:pulzion23/features/home_page/ui/home_page_final.dart';
import 'package:pulzion23/pages/about_us_page/ui/about_us.dart';
import 'package:pulzion23/pages/more_page/ui/more_main.dart';
import 'package:pulzion23/project/cubit/bottom_bar_cubit.dart';

import '../../../constants/images.dart';
import '../../home_page/ui/wigets/custom_appbar.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
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
          body: BlocBuilder<BottomBarCubit, BottomBarState>(
            builder: (context, state) {
              if (state is BottomBarAboutUs) {
                return AboutUsPage();
              } else if (state is BottomBarRegisteredEvents) {
                return const Center(
                  child: Text(
                    "Registered Events",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else if (state is BottomBarHome) {
                return const HomePageContent();
              } else if (state is BottomBarCart) {
                return const CartPage();
              } else {
                return FrostedGlassTile();
              }
            },
          ),
          bottomNavigationBar: Container(
            margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: CurvedNavigationBar(
              index: 2,
              height: MediaQuery.of(context).size.height * 0.07,
              items: const <Widget>[
                Icon(Icons.info, size: 30),
                Icon(Icons.calendar_month, size: 30),
                Icon(Icons.home_rounded, size: 30),
                Icon(Icons.shopping_cart, size: 30),
                Icon(Icons.more_horiz_rounded, size: 30),
              ],
              color: Colors.white,
              buttonBackgroundColor: Colors.white,
              backgroundColor: Colors.transparent,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 400),
              onTap: (index) {
                context.read<BottomBarCubit>().changeIndex(index);
              },
              letIndexChange: (index) => true,
            ),
          ),
        ),
      ],
    );
  }
}
