import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class PulzionBlocObserver extends BlocObserver {
  var logger = Logger();

  @override
  void onCreate(BlocBase bloc) {
    // called whenever a bloc is instantiated.
    super.onCreate(bloc);
    logger.i('[BLoC INFO] ${bloc.runtimeType}: created');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    // called whenever an event is added
    super.onEvent(bloc, event);
    logger.i('[BLoC INFO] ${bloc.runtimeType}: $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    // called whenever a state is emitted
    super.onChange(bloc, change);
    logger.i('[BLoC INFO] ${bloc.runtimeType}: $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // called whenever an error is thrown
    super.onError(bloc, error, stackTrace);
    logger.e('[BLoC INFO] ${bloc.runtimeType}: $error');
  }

  @override
  void onClose(BlocBase bloc) {
    // called whenever a bloc is disposed
    super.onClose(bloc);
    logger.i('[BLoC INFO] ${bloc.runtimeType}: closed');
  }
}
