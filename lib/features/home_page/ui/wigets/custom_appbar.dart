import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/images.dart';
import '../../../profile_page/cubit/profile_cubit.dart';
import '../../../profile_page/ui/profileui.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: (() async {
              // Logout button for now
              // await context.read<CheckLoginCubit>().logout();
              // await context.read<CheckLoginCubit>().checkLogin();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BlocProvider<ProfileCubit>(
                    create: (BuildContext context) => ProfileCubit()..getUser(),
                    child: const ProfilePage(),
                  ),
                ),
              );
            }),
            child: const CircleAvatar(
              backgroundImage: AssetImage(AppImages.person),
            ),
          ),
        ),
      ],
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
