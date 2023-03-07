import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'bottom_bar_state.dart';

class BottomBarCubit extends Cubit<BottomBarState> {
  BottomBarCubit() : super(BottomBarHome());

  int index = 2;

  void changeIndex(int index) {
    this.index = index;
    if (index == 0) {
      emit(BottomBarAboutUs());
    } else if (index == 1) {
      emit(BottomBarRegisteredEvents());
    } else if (index == 2) {
      emit(BottomBarHome());
    } else if (index == 3) {
      emit(BottomBarCart());
    } else if (index == 4) {
      emit(BottomBarMore());
    }
  }
}
