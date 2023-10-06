import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulzion23/constants/widgets/loader.dart';
import 'package:pulzion23/features/splash_screen/cubit/splash_cubit.dart';
import 'package:pulzion23/main.dart';
import 'package:pulzion23/project/cubit/animation_toggle_cubit.dart';
import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          log(state.toString());
          if (state is SplashPreInitial) {
            BlocProvider.of<SplashCubit>(context).checkSplash();

            return Container();
          } else if (state is SplashInitial) {
            BlocProvider.of<SplashCubit>(context).init();

            return Container();
          } else if (state is SplashScreenDone || state is NoSplashScreen) {
            BlocProvider.of<GlobalParameterCubit>(context).init();
            // BlocProvider.of<GlobalParameterCubit>(context).soundOnOff();

            return const Pulzion23App();
          } else if (state is SplashVideoEnded) {
            BlocProvider.of<SplashCubit>(context).dispose();

            return const Loader();
          } else if (state is SplashStart) {
            BlocProvider.of<SplashCubit>(context).start();
            final _controller =
                BlocProvider.of<SplashCubit>(context).controller;

            return Center(
              child: AspectRatio(
                aspectRatio: MediaQuery.of(context).size.width /
                    MediaQuery.of(context).size.height,
                child: VideoPlayer(_controller),
              ),
            );
          }

          return const Loader();
        },
      ),
    );
  }
}
