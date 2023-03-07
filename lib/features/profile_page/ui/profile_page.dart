import 'dart:developer';

import 'package:flutter/material.dart';

import '../../../constants/styles.dart';

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
              log("Go to Landing page");
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
