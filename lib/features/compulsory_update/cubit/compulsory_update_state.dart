part of 'compulsory_update_cubit.dart';

@immutable
abstract class CompulsoryUpdateState {}

class CompulsoryUpdateLoading extends CompulsoryUpdateState {}

class CompulsoryUpdateNeeded extends CompulsoryUpdateState {}

class CompulsoryUpdateNotNeeded extends CompulsoryUpdateState {}
