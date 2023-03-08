part of 'compulsory_update_cubit.dart';

@immutable
abstract class CompulsoryUpdateState {}

class CompulsoryUpdateInitial extends CompulsoryUpdateState {}

class CompulsoryUpdateLoading extends CompulsoryUpdateState {}

class CompulsoryUpdateNeeded extends CompulsoryUpdateState {}

class CompulsoryUpdateNotNeeded extends CompulsoryUpdateState {}

class CompulsoryUpdateError extends CompulsoryUpdateState {
  final String message;

  CompulsoryUpdateError(this.message);
}
