import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:video_player/video_player.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  late VideoPlayerController _controller;

  VideoPlayerController get controller => _controller;

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

  Future<void> init() async {
    emit(SplashLoading());
    _controller = VideoPlayerController.asset('assets/video/intro.mp4');
    await _controller.initialize();
    emit(SplashStart());
  }
}
