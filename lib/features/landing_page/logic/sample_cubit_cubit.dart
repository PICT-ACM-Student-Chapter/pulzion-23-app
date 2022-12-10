import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sample_cubit_state.dart';

class SampleCubitCubit extends Cubit<SampleCubitState> {
  SampleCubitCubit() : super(SampleCubitInitial());

  void load() async {
    emit(SampleCubitLoading());
    try {
      await Future.delayed(const Duration(seconds: 2));
      emit(SampleCubitLoaded('Loaded'));
    } catch (e) {
      emit(SampleCubitError(e.toString()));
    }
  }
}
