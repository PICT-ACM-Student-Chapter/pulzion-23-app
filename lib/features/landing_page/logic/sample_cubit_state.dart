part of 'sample_cubit_cubit.dart';

@immutable
abstract class SampleCubitState {}

class SampleCubitInitial extends SampleCubitState {}

class SampleCubitLoading extends SampleCubitState {}

class SampleCubitLoaded extends SampleCubitState {
  final String message;

  SampleCubitLoaded(this.message);
}

class SampleCubitError extends SampleCubitState {
  final String message;

  SampleCubitError(this.message);
}
