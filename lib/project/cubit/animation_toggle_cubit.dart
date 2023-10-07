import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class GlobalParameterCubit extends Cubit<bool> {
  bool _controller = true;

  bool get controller => _controller;

  AssetsAudioPlayer? _audioPlayer;

  GlobalParameterCubit() : super(true) {
    init();
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? check = prefs.getBool('soundController');

    _controller = check ?? true;

    if (_audioPlayer == null) {
      _audioPlayer = AssetsAudioPlayer();
      _audioPlayer!
          .open(
            Audio("assets/audios/halloween_sound.mp3"),
            autoStart: _controller,
            showNotification: false,
            loopMode: LoopMode.playlist,
          )
          .then((value) {})
          .catchError((error) {});
    }
    soundOnOff(_audioPlayer, _controller);
    emit(_controller);
  }

  static void soundOnOff(AssetsAudioPlayer? audioAssets, bool controller) {
    if (controller) {
      if (!audioAssets!.isPlaying.value) {
        audioAssets.play();
      }
    } else {
      if (audioAssets!.isPlaying.value) {
        audioAssets.stop();
      }
    }
  }

  Future<void> toggleParameter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool getController = prefs.getBool('soundController') ?? _controller;
    _controller = !getController;
    soundOnOff(_audioPlayer, _controller);
    await prefs.setBool('soundController', _controller);
    emit(_controller);
  }

  void stopSound() {
    if (_audioPlayer != null) {
      if (_audioPlayer!.isPlaying.value) {
        _audioPlayer!.stop();
      }
    }
  }
}
