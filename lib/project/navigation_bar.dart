import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
      child: CurvedNavigationBar(
        index: 2,
        height: MediaQuery.of(context).size.height * 0.07,
        items: const <Widget>[
          Icon(Icons.login_rounded, size: 30),
          Icon(Icons.monetization_on_rounded, size: 30),
          Icon(Icons.home_rounded, size: 30),
          Icon(Icons.laptop_mac_rounded, size: 30),
          Icon(Icons.more_horiz_rounded, size: 30),
        ],
        color: Colors.white,
        buttonBackgroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 400),
        onTap: (index) {},
        letIndexChange: (index) => true,
      ),
    );
  }
}
