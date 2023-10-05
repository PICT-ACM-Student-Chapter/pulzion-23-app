part of 'combo_cubit.dart';

class ComboState {}

class ComboInitial extends ComboState {}

class ComboLoading extends ComboState {}

class ComboError extends ComboState {
  String error;
  ComboError({required this.error});
}

class ComboLoaded extends ComboState {
  List<Combo> combosList;
  ComboLoaded({required this.combosList});
}
