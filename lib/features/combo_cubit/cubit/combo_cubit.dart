import 'dart:developer';

import 'package:bloc/bloc.dart';
import '../models/combo_model.dart';

part 'combo_state.dart';

class ComboCubit extends Cubit<ComboState> {
  ComboCubit() : super(ComboInitial()) {
    log("START COMBO");
  }
}
