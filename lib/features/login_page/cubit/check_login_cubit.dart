import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../constants/static_objects.dart';

part 'check_login_state.dart';

class CheckLoginCubit extends Cubit<CheckLoginState> {
  CheckLoginCubit() : super(CheckLoginInitial());

  Future<void> checkLogin() async {
    emit(CheckLoginLoading());
    try {
      // Check if token is present in Singleton or not
      if (Singleton.userToken != null) {
        emit(CheckLoginSuccess());
        return;
      } else {
        const storage = FlutterSecureStorage();
        final token = await storage.read(key: 'token');
        if (token != null) {
          emit(CheckLoginSuccess());
          return;
        } else {
          emit(CheckLoginFailure('No token found'));
          return;
        }
      }
    } catch (e) {
      emit(CheckLoginFailure(e.toString()));
    }
  }
}
