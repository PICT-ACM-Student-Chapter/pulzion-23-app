import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashPreInitial());

  late bool isSplash;
  late VideoPlayerController _controller;

  VideoPlayerController get controller => _controller;

  bool get isSplashScreen => isSplash;

  Future<void> checkSplash() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSplash = prefs.getBool('splashController') ?? true;
    if (isSplash) {
      emit(SplashInitial());
    } else {
      emit(NoSplashScreen());
    }
  }

  void dispose() async {
    await _controller.dispose();
    emit(SplashScreenDone());
  }

  void start() async {
    _controller.addListener(() {
      if (_controller.value.position == _controller.value.duration) {
        emit(SplashVideoEnded());
      }
    });
    await _controller.play();
  }

  Future<void> toggleParameter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool getController = prefs.getBool('splashController') ?? true;
    log("Splash screen before value $isSplash");
    isSplash = !getController;
    log("Splash screen after value $isSplash");
    await prefs.setBool('splashController', isSplash);
  }

  Future<void> init() async {
    emit(SplashLoading());
    _controller = VideoPlayerController.asset('assets/video/intro.mp4');
    await _controller.initialize();
    emit(SplashStart());
  }
}
