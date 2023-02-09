import 'package:flutter/material.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  Widget buildHeader(BuildContext context) => Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top));

  Widget buildMenuItems(BuildContext context) => Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height / 30),
        child: Wrap(
          runSpacing: MediaQuery.of(context).size.height / 50,
          children: [
            ListTile(
              leading: const Icon(
                Icons.home_filled,
              ),
              title: const Text(
                'Home',
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.pie_chart_sharp,
              ),
              title: const Text(
                'Pie Chart',
              ),
              onTap: (() {
                Navigator.pop(context);
              }),
            ),
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [buildHeader(context), buildMenuItems(context)],
        ),
      ),
    );
  }
}
