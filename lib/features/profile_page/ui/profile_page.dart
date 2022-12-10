// A simple profile page with a profile image, name, and description.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pulzion23/constants/styles.dart';
import 'package:pulzion23/project/routes/app_route_constant.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
        actions: [
          IconButton(
            onPressed: () {
              context.goNamed(RouteName.landing);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: Center(
        child: Text('Profile Page', style: AppStyles.bodyTextStyle1()),
      ),
    );
  }
}
