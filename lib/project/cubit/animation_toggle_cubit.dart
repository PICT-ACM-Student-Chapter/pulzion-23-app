import 'package:bloc/bloc.dart';

class GlobalParameterCubit extends Cubit<bool> {
  bool _controller = true;
  GlobalParameterCubit() : super(true);

  void toggleParameter() {
    _controller = !_controller;
    emit(_controller);
  }
}
