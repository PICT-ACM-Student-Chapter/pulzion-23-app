import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GlobalParameterCubit extends Cubit<bool> {
  bool _controller = true;
  GlobalParameterCubit() : super(true) {
    init();
  }

  Future<void> init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    _controller = prefs.getBool('controller') ?? true;
    emit(_controller);
  }

  Future<void> toggleParameter() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool getController = prefs.getBool('controller') ?? true;
    _controller = !getController;
    await prefs.setBool('controller', _controller);
    emit(_controller);
  }
}
