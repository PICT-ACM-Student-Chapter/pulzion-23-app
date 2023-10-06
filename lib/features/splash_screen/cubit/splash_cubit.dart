import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashPreInitial());

  bool _isSplash = true;
  late VideoPlayerController _controller;

  VideoPlayerController get controller => _controller;

  bool get isSplashScreen => _isSplash;

  Future<void> checkSplash() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _isSplash = prefs.getBool('splashController') ?? true;
    if (_isSplash) {
      emit(SplashInitial());
    } else {
      emit(NoSplashScreen());
    }
  }

  void start() async {
    _controller.addListener(() async {
      if (_controller.value.position == _controller.value.duration) {
        emit(SplashLoading());
        await _controller.dispose();
        emit(SplashScreenDone());
      }
    });
    await _controller.play();
  }

  Future<void> toggleParameter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool getController = prefs.getBool('splashController') ?? true;
    // log("Splash screen before value $_isSplash");
    _isSplash = !getController;
    // log("Splash screen after value $_isSplash");
    await prefs.setBool('splashController', _isSplash);
  }

  Future<void> init() async {
    emit(SplashLoading());
    _controller = VideoPlayerController.asset('assets/video/intro.mp4');
    await _controller.initialize();
    emit(SplashStart());
  }
}
